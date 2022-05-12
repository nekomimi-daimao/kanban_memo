// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class DbToJson {
  static void export(String json) {
    final now = DateTime.now();
    final anchor =
        AnchorElement(href: "data:application/json;charset=utf-8,$json");
    anchor.download =
        "kanban_memo_${now.year}${now.month.toString().padLeft(2, "0")}${now.day.toString().padLeft(2, "0")}.json";
    anchor.click();
  }
}
