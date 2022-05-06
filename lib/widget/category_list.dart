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
      child: Column(
        children: [
          TextField(
            controller:
                TextEditingController(text: widget.categoryData.category),
            onChanged: (v) {
              setState(() {
                widget.categoryData.category = v;
              });
            },
          ),
          Flexible(
            child: ReorderableListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              primary: false,
              // buildDefaultDragHandles: false,
              children: memoData.map((e) => MemoCard(data: e)).toList(),
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  // removing the item at oldIndex will shorten the list by 1.
                  newIndex -= 1;
                }
                var c = widget.memoData.removeAt(oldIndex);
                setState(() {
                  widget.memoData.insert(newIndex, c);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
