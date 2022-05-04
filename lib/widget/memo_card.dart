import 'package:flutter/material.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';

class MemoCard extends StatefulWidget {
  final MemoData data;

  const MemoCard({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MemoCardState();
  }
}

class _MemoCardState extends State<MemoCard> {
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.data.title;
    memoController.text = widget.data.memo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLines: 1,
            onChanged: (v) {
              setState(() {
                widget.data.title = v;
              });
            },
          ),
          TextField(
            controller: memoController,
            maxLines: null,
            onChanged: (v) {
              setState(() {
                widget.data.memo = v;
              });
            },
          ),
        ],
      ),
    );
  }
}
