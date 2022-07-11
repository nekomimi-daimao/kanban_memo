import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

class SortBoardDialog extends StatelessWidget {
  final List<BoardData> boardData;

  const SortBoardDialog.create(this.boardData, {Key? key}) : super(key: key);

  Future<EditResultType?> show(BuildContext context) {
    return showDialog<EditResultType>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return this;
        });
  }

  @override
  Widget build(BuildContext context) {
    var list = ReorderableListView(
        shrinkWrap: true,
        children: boardData
            .map((e) => ListTile(
                  key: Key('$e.id'),
                  title: Text(e.title),
                ))
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = boardData.removeAt(oldIndex);
          boardData.insert(newIndex, item);
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
            boardData.whereNotNull().toList().asMap().forEach((key, value) {
              value.index = key;
            });
            Navigator.of(context).pop(EditResultType.submit);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
