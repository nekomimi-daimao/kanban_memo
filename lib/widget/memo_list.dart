import 'package:flutter/material.dart';
import 'package:kanban_memo/model/memo_data.dart';

class MemoList extends StatefulWidget {
  const MemoList({Key? key, required this.category, required this.data})
      : super(key: key);

  final String category;
  final List<MemoData> data;

  @override
  State<StatefulWidget> createState() {
    return MemoListState();
  }
}

class MemoListState extends State<MemoList> {
  List<Card> memoCards = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      var c = Card(
        key: Key("$i"),
        child: Text(i.toString(), style: const TextStyle(fontSize: 32.0)),
        elevation: 4,
      );
      memoCards.add(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: ReorderableListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: memoCards
                .map((e) => Center(
                      key: e.key,
                      child: e,
                    ))
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
              print('$oldIndex -> $newIndex');
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var c = memoCards.removeAt(oldIndex);
              setState(() {
                memoCards.insert(newIndex, c);
              });
            }));
  }
}
