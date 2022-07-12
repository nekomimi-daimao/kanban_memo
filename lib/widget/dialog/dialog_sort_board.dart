import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

class SortBoardDialog extends StatefulWidget {
  final List<BoardData> boardData;

  const SortBoardDialog.create(this.boardData, {Key? key}) : super(key: key);

  @override
  State<SortBoardDialog> createState() => _SortBoardDialogState();

  Future<EditResultType?> show(BuildContext context) {
    return showDialog<EditResultType>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return this;
        });
  }
}

class _SortBoardDialogState extends State<SortBoardDialog> {
  void sortIndex() {
    widget.boardData.whereNotNull().toList().asMap().forEach((key, value) {
      value.index = key;
    });
  }

  @override
  void initState() {
    super.initState();
    sortIndex();
  }

  @override
  Widget build(BuildContext context) {
    var list = ReorderableListView(
        shrinkWrap: true,
        children: widget.boardData
            .map((e) => ListTile(
                  key: Key('$e.id'),
                  title: Text(e.title),
                  tileColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(e.index.isOdd ? 0.5 : 0.1),
                ))
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = widget.boardData.removeAt(oldIndex);
          widget.boardData.insert(newIndex, item);
          setState(() {
            sortIndex();
          });
        });

    return AlertDialog(
      title: const Text("Sort Board"),
      content: SizedBox(
        width: 400,
        child: list,
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(EditResultType.cancel);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            sortIndex();
            Navigator.of(context).pop(EditResultType.submit);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
