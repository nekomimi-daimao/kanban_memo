import 'package:isar/isar.dart';

part 'board_data.g.dart';

@Collection()
class BoardData {
  @Id()
  int? id;

  int index = 0;
  String title = "";

  BoardData();

  BoardData.create(this.title);

  BoardData.empty() {
    id = -1;
    index = -1;
  }

  bool isEmpty() => id == -1;

  @override
  String toString() {
    return 'BoardData{id: $id, index: $index, title: $title}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          index == other.index &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ index.hashCode ^ title.hashCode;
}
