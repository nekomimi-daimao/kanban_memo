import 'package:flutter/material.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_memo.dart';

class MemoCard extends StatefulWidget {
  final MemoData data;

  const MemoCard({Key? key, required this.data}) : super(key: key);

  @override
  Key? get key => Key(data.id.toString());

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
    return Draggable(
      data: widget.data,
      child: buildCard(),
      feedback: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).backgroundColor,
            border: Border.all(
              color: Theme.of(context).focusColor,
              width: 10,
            )),
        child: Icon(
          Icons.article,
          color: Theme.of(context).focusColor,
          size: 24.0,
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            )),
        child: Icon(
          Icons.article,
          color: Theme.of(context).primaryColor,
          size: 24.0,
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      color: Theme.of(context).cardColor,
      // elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              onChanged: (v) {
                widget.data.title = v;
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return EditMemoDialog(
                      memoData: widget.data,
                    );
                  },
                );
              },
            ),
            TextField(
              controller: memoController,
              maxLines: null,
              onChanged: (v) {
                widget.data.memo = v;
              },
            ),
          ],
        ),
      ),
    );
  }
}
