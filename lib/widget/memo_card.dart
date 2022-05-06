import 'package:flutter/material.dart';
import 'package:kanban_memo/db/dao.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildCard();
  }

  Card buildCard() {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () async {
          await showMemoDialog();
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

  Future<void> showMemoDialog() async {
    var requireSave = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return EditMemoDialog(
          memoData: widget.data,
        );
      },
    );
    if (requireSave != null && requireSave) {
      Dao().putMemo(widget.data);
    }
  }
}
