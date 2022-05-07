import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/model/memo/memo_data.dart';

class EditMemoDialog extends HookConsumerWidget {
  EditMemoDialog({Key? key, required this.memoData}) : super(key: key);

  final MemoData memoData;

  // workaround 4 double.infinity
  static const double dummyWidth = 1000000;

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }

  final titleEditingProvider =
      AutoDisposeStateProviderFamily<TextEditingController, String>(
          (ref, initial) {
    return TextEditingController(text: initial);
  });
  final memoEditingProvider =
      AutoDisposeStateProviderFamily<TextEditingController, String>(
          (ref, initial) {
    return TextEditingController(text: initial);
  });

  final allowDeleteProvider = AutoDisposeStateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var titleController = ref.watch(titleEditingProvider(memoData.title));
    var memoController = ref.watch(memoEditingProvider(memoData.memo));
    return AlertDialog(
      insetPadding: const EdgeInsets.all(80),
      content: Container(
        width: dummyWidth,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              decoration: _decoration("Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                controller: memoController,
                maxLines: null,
                minLines: 10,
                decoration: _decoration("Memo"),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Checkbox(
            value: ref.watch(allowDeleteProvider),
            onChanged: (checked) {
              if (checked == null) {
                return;
              }
              ref.read(allowDeleteProvider.notifier).state = checked;
            }),
        ElevatedButton(
          onPressed: !ref.watch(allowDeleteProvider)
              ? null
              : () {
                  // TODO delete
                  Navigator.of(context).pop(true);
                },
          child: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
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
