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
}