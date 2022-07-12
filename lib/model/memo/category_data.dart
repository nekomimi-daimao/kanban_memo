import 'package:isar/isar.dart';
import 'package:kanban_memo/model/memo/board_data.dart';

part 'category_data.g.dart';

@Collection()
class CategoryData {
  @Id()
  int? id;

  int? boardId;

  int index = 0;
  String category = "";

  CategoryData();

  CategoryData.create(BoardData boardData, this.category) {
    boardId = boardData.id;
    index = 0;
  }

  @override
  String toString() {
    return 'CategoryData{id: $id, boardId: $boardId, index: $index, category: $category}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          boardId == other.boardId &&
          index == other.index &&
          category == other.category;

  @override
  int get hashCode =>
      id.hashCode ^ boardId.hashCode ^ index.hashCode ^ category.hashCode;
}
