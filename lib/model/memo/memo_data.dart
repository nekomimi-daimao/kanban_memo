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

  int index = 0;
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

  String toStringFull() {
    return 'MemoData{id: $id, boardId: $boardId, categoryId: $categoryId, index: $index, title: $title, memo: $memo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          boardId == other.boardId &&
          categoryId == other.categoryId &&
          index == other.index &&
          title == other.title &&
          memo == other.memo;

  @override
  int get hashCode =>
      id.hashCode ^
      boardId.hashCode ^
      categoryId.hashCode ^
      index.hashCode ^
      title.hashCode ^
      memo.hashCode;
}
