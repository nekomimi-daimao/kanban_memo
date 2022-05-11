// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class DbToJson {
  static void export(String json) {
    var anchor =
        AnchorElement(href: "data:application/json;charset=utf-8,$json");
    anchor.download = "kanban_memo.json";
    anchor.click();
  }
}
