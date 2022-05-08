import 'dart:collection';

import 'package:collection/collection.dart';

import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';

class Dao {
  static final Dao _instance = Dao._internal();

  factory Dao() {
    return _instance;
  }

  Dao._internal();

  late Isar _isar;

  Future initialize() async {
    var schemas = [
      MemoDataSchema,
      CategoryDataSchema,
      BoardDataSchema,
    ];

    if (kIsWeb) {
      _isar = await Isar.open(
        schemas: schemas,
        inspector: !kIsWeb,
      );
    } else {
      final dir = await getApplicationSupportDirectory();
      _isar = await Isar.open(
        schemas: schemas,
        inspector: !kIsWeb,
        directory: dir.path,
      );
    }
  }

  Stream<void> boardStream() {
    return _isar.boardDatas.watchLazy();
  }

  Stream<void> categoryStream() {
    return _isar.categoryDatas.watchLazy();
  }

  Stream<void> memoStream() {
    return _isar.memoDatas.watchLazy();
  }

  Future<List<BoardData>> allBoard() {
    return _isar.boardDatas.where().sortByCreated().findAll();
  }

  Future<LinkedHashMap<CategoryData, List<MemoData>>> boardMap(
      BoardData data) async {
    var categories = await boardCategory(data);
    var memos = await boardMemo(data);
    // ignore: prefer_collection_literals
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

  Future<List<MemoData>> boardMemoFromId(int boardDataId) {
    return _isar.memoDatas.filter().boardIdEqualTo(boardDataId).findAll();
  }

  Future<List<MemoData>> categoryMemo(CategoryData categoryData) {
    return _isar.memoDatas
        .filter()
        .categoryIdEqualTo(categoryData.id)
        .findAll();
  }

  Future<List<MemoData>> categoryMemoFromId(int categoryDataId) {
    return _isar.memoDatas.filter().categoryIdEqualTo(categoryDataId).findAll();
  }

  Future putMemo(MemoData memoData) {
    return _isar.writeTxn((isar) async {
      memoData.id = await isar.memoDatas.put(memoData);
    });
  }

  Future putAllMemo(List<MemoData> memoData) {
    return _isar.writeTxn((isar) async {
      await isar.memoDatas.putAll(memoData);
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

  Future insertMemo(int categoryId, MemoData memoData, int insertIndex) async {
    var categoryMemos = await categoryMemoFromId(categoryId);
    if (categoryMemos.isEmpty) {
      return;
    }

    var sameCategory = memoData.categoryId == categoryId;

    if (!sameCategory) {
      var sample = categoryMemos.first;
      memoData.boardId = sample.boardId;
      memoData.categoryId = sample.categoryId;
    }

    var index = categoryMemos.indexWhere((e) => e.index == insertIndex);
    if (index < 0) {
      index = 0;
    }
    if (sameCategory) {
      categoryMemos.removeWhere((e) => e.id == memoData.id);
    }

    categoryMemos.insert(index, memoData);
    categoryMemos.asMap().forEach((key, value) {
      value.index = key;
    });
    await putAllMemo(categoryMemos);
  }

  Future deleteMemo(MemoData memoData) {
    var id = memoData.id;
    if (id == null) {
      return Future.value();
    }
    return _isar.writeTxn((isar) async {
      _isar.memoDatas.delete(id);
    });
  }

  Future deleteCategory(CategoryData categoryData) async {
    var id = categoryData.id;
    if (id == null) {
      return Future.value();
    }
    return _isar.writeTxn((isar) async {
      var deleteMemo =
          _isar.memoDatas.filter().categoryIdEqualTo(id).deleteAll();
      var deleteCategory = _isar.categoryDatas.delete(id);
      await Future.wait([
        deleteMemo,
        deleteCategory,
      ]);
    });
  }

  Future deleteBoard(BoardData boardData) async {
    var id = boardData.id;
    if (id == null) {
      return Future.value();
    }
    return _isar.writeTxn((isar) async {
      var deleteMemo = _isar.memoDatas.filter().boardIdEqualTo(id).deleteAll();
      var deleteCategory =
          _isar.categoryDatas.filter().boardIdEqualTo(id).deleteAll();
      var deleteBoard = _isar.boardDatas.delete(id);
      await Future.wait([
        deleteMemo,
        deleteCategory,
        deleteBoard,
      ]);
    });
  }

  Future clearAll() {
    return _isar.writeTxn((isar) async {
      var allBoard = await isar.boardDatas.where().findAll();
      var deleteBoard = isar.boardDatas
          .deleteAll(allBoard.map((e) => e.id).whereNotNull().toList());

      var allCategory = await isar.categoryDatas.where().findAll();
      var deleteCategory = isar.categoryDatas
          .deleteAll(allCategory.map((e) => e.id).whereNotNull().toList());

      var allMemo = await isar.memoDatas.where().findAll();
      var deleteMemo = isar.memoDatas
          .deleteAll(allMemo.map((e) => e.id).whereNotNull().toList());

      await Future.wait([deleteBoard, deleteCategory, deleteMemo]);
    });
  }
}
