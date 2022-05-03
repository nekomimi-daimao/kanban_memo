import 'package:isar/isar.dart';

part 'category_data.g.dart';

@Collection()
class CategoryData {
  @Id()
  int? id;

  int? boardId;

  String category = "";
  late DateTime created;
}
