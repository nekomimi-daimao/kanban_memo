import 'package:flutter/material.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/memo_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList(
      {Key? key, required this.categoryData, required this.memoData})
      : super(key: key);

  final CategoryData categoryData;
  final List<MemoData> memoData;

  @override
  State<StatefulWidget> createState() {
    return CategoryListState();
  }
}

class CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    var memoData = widget.memoData;
    memoData.sort((a, b) => a.index.compareTo(b.index));

    return SizedBox(
        width: 200,
        child: ReorderableListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: memoData.map((e) => MemoCard(data: e)).toList(),
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              setState(() {
                var c = widget.memoData.removeAt(oldIndex);
                widget.memoData.insert(newIndex, c);
              });
            }));
  }
}