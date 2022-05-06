import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/model/memo/memo_data.dart';

class EditMemoDialog extends HookConsumerWidget {
  const EditMemoDialog({Key? key, required this.memoData}) : super(key: key);

  final MemoData memoData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: Column(
        children: [
          TextField(
            controller: TextEditingController(text: memoData.title),
            maxLines: 1,
            onChanged: (v) {
              memoData.title = v;
            },
          ),
          TextField(
            controller: TextEditingController(text: memoData.memo),
            maxLines: null,
            onChanged: (v) {
              memoData.memo = v;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text("save"),
        ),
      ],
    );
  }
}
