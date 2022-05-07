import 'package:flutter/material.dart';
import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';

import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/memo_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList(
      {Key? key,
      required this.boardData,
      required this.categoryData,
      required this.memoData})
      : super(key: key);

  final BoardData boardData;
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
    var addTile = ListTile(
      key: const Key("add"),
      title: const Icon(Icons.add_box_rounded),
      onTap: () async {
        var newMemo = MemoData.create(widget.boardData, widget.categoryData);
        var lastIndex =
            widget.memoData.isNotEmpty ? widget.memoData.last.index : 0;
        newMemo.index = lastIndex + 1;
        widget.memoData.add(newMemo);
        await Dao().putMemo(newMemo);
      },
    );

    List<Widget> items = [];
    items.addAll(memoData.map((e) => MemoCard(data: e)).toList());
    items.add(addTile);

    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextField(
            controller:
                TextEditingController(text: widget.categoryData.category),
            textAlign: TextAlign.center,
            onChanged: (v) {
              widget.categoryData.category = v;
            },
          ),
          Flexible(
            child: ReorderableListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              primary: false,
              buildDefaultDragHandles: false,
              children: items,
              onReorder: (oldIndex, newIndex) {
                if (items[oldIndex].key == addTile.key ||
                    newIndex == items.length) {
                  return;
                }
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                var c = widget.memoData.removeAt(oldIndex);
                widget.memoData.insert(newIndex, c);
                widget.memoData.asMap().forEach((key, value) {
                  value.index = key;
                });
                Dao().putAllMemo(widget.memoData);
              },
            ),
          )
        ],
      ),
    );
  }
}
