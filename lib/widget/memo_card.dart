import 'package:flutter/material.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_memo.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableDelayedDragStartListener(
      index: widget.data.index,
      child: buildCard(),
    );
  }

  Card buildCard() {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          _editMemo(widget.data);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                widget.data.title,
                maxLines: 1,
              ),
              Text(
                widget.data.memo,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _editMemo(MemoData memoData) async {
    var editResult = await EditMemoDialog.show(context, memoData);
    if (editResult == null) {
      return;
    }
    switch (editResult) {
      case EditResultType.cancel:
        // Nothing
        break;
      case EditResultType.submit:
        Dao().putMemo(memoData);
        break;
      case EditResultType.delete:
        Dao().deleteMemo(memoData);
        break;
    }
  }
}
