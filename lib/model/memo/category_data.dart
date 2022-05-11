import 'package:isar/isar.dart';
import 'package:kanban_memo/model/memo/board_data.dart';

part 'category_data.g.dart';

@Collection()
class CategoryData {
  @Id()
  int? id;

  int? boardId;

  String category = "";
  late DateTime created;

  CategoryData();

  CategoryData.create(BoardData boardData, this.category) {
    boardId = boardData.id;
    created = DateTime.now().toUtc();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          boardId == other.boardId &&
          category == other.category &&
          created == other.created;

  @override
  int get hashCode =>
      id.hashCode ^ boardId.hashCode ^ category.hashCode ^ created.hashCode;
}
