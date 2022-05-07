import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditTextDialogBuilder {
  String title;
  String submit = "Submit";
  String cancel = "Cancel";

  EditTextDialogBuilder(this.title);

  EditTextDialog build() {
    return EditTextDialog._builder(this);
  }
}

class EditTextDialog extends HookConsumerWidget {
  final String title;
  final String cancel;
  final String submit;

  EditTextDialog._builder(EditTextDialogBuilder builder)
      : title = builder.title,
        submit = builder.submit,
        cancel = builder.cancel;

  static EditTextDialogBuilder builder(String title) {
    return EditTextDialogBuilder(title);
  }

  Future<String?> show(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (_) {
          return this;
        });
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: TextFormField(
        controller: _textEditingController,
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Empty!";
          }
          return null;
        },
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_textEditingController.text);
          },
          child: Text(submit),
        ),
      ],
    );
  }
}
