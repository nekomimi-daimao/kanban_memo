import 'package:isar/isar.dart';

part 'board_data.g.dart';

@Collection()
class BoardData {
  @Id()
  int? id;

  String title = "";
  late DateTime created;

  BoardData();

  BoardData.create(this.title) {
    created = DateTime.now();
  }

  BoardData.empty() {
    id = -1;
    created = DateTime.fromMillisecondsSinceEpoch(0);
  }

  bool isEmpty() => id == -1;

  @override
  String toString() {
    return 'BoardData{id: $id, title: $title, created: $created}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          created == other.created;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ created.hashCode;
}
