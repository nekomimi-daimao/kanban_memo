import 'package:isar/isar.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';

part 'memo_data.g.dart';

@Collection()
class MemoData {
  @Id()
  int? id;

  int? boardId;
  int? categoryId;

  String title = "";
  String memo = "";

  MemoData({
    required this.boardId,
    required this.categoryId,
  });

  factory MemoData.create(BoardData boardData, CategoryData categoryData) {
    return MemoData(boardId: boardData.id, categoryId: categoryData.id);
  }

  @override
  String toString() {
    return 'MemoData{title: $title, memo: $memo}';
  }
}
