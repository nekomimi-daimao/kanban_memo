import 'dart:collection';

import 'package:isar/isar.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:path_provider/path_provider.dart';

class Dao {
  static final Dao _instance = Dao._internal();

  factory Dao() {
    return _instance;
  }

  Dao._internal();

  late Isar _isar;

  Future<void> initialize() async {
    final dir = await getApplicationSupportDirectory();
    _isar = await Isar.open(schemas: [
      MemoDataSchema,
      CategoryDataSchema,
      BoardDataSchema,
    ], directory: dir.path, inspector: true);
  }

  Future<List<BoardData>> allBoard() {
    return _isar.boardDatas.where().sortByCreated().findAll();
  }

  Future<LinkedHashMap<CategoryData, List<MemoData>>> boardMap(
      BoardData data) async {
    var categories = await boardCategory(data);
    var memos = await boardMemo(data);
    var map = LinkedHashMap<CategoryData, List<MemoData>>();
    for (var c in categories) {
      map[c] = memos.where((m) => m.categoryId == c.id).toList();
    }
    return map;
  }

  Future<List<CategoryData>> boardCategory(BoardData boardData) {
    return _isar.categoryDatas
        .filter()
        .boardIdEqualTo(boardData.id)
        .sortByCreated()
        .findAll();
  }

  Future<List<MemoData>> boardMemo(BoardData boardData) {
    return _isar.memoDatas.filter().boardIdEqualTo(boardData.id).findAll();
  }

  Future putMemo(MemoData memoData) {
    return _isar.writeTxn((isar) async {
      memoData.id = await isar.memoDatas.put(memoData);
    });
  }

  Future putCategory(CategoryData categoryData) {
    return _isar.writeTxn((isar) async {
      categoryData.id = await isar.categoryDatas.put(categoryData);
    });
  }

  Future putBoard(BoardData boardData) {
    return _isar.writeTxn((isar) async {
      boardData.id = await isar.boardDatas.put(boardData);
    });
  }
}
