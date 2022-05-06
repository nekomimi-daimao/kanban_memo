import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/model/memo/memo_data.dart';

class EditMemoDialog extends HookConsumerWidget {
  const EditMemoDialog({Key? key, required this.memoData}) : super(key: key);

  final MemoData memoData;

  // workaround 4 double.infinity
  static const double dummyWidth = 1000000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var titleController = TextEditingController(text: memoData.title);
    var memoController = TextEditingController(text: memoData.memo);
    return AlertDialog(
      insetPadding: const EdgeInsets.all(80),
      content: Container(
        width: dummyWidth,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
            ),
            TextField(
              controller: memoController,
              maxLines: null,
              minLines: 6,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            memoData.title = titleController.text;
            memoData.memo = titleController.text;
            Navigator.of(context).pop(true);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
