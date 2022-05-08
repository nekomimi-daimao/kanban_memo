import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

class EditDataDialogBuilder {
  String title;
  String submit = "Submit";
  String cancel = "Cancel";
  String initialValue = "";

  EditDataDialogBuilder(this.title);

  EditDataDialog build() {
    return EditDataDialog._builder(this);
  }
}

@immutable
class EditDataResult {
  final EditResultType resultType;
  final String? input;

  const EditDataResult(this.resultType, this.input);
}

class EditDataDialog extends HookConsumerWidget {
  final String title;
  final String cancel;
  final String submit;
  final String initialValue;
  final TextEditingController _textEditingController;

  EditDataDialog._builder(EditDataDialogBuilder builder)
      : title = builder.title,
        submit = builder.submit,
        cancel = builder.cancel,
        initialValue = builder.initialValue,
        _textEditingController =
            TextEditingController(text: builder.initialValue);

  static EditDataDialogBuilder builder(String title) {
    return EditDataDialogBuilder(title);
  }

  Future<EditDataResult?> show(BuildContext context) {
    return showDialog<EditDataResult>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return this;
        });
  }

  final allowDeleteProvider = AutoDisposeStateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> actions = [];
    actions.addAll([
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
                Navigator.of(context)
                    .pop(const EditDataResult(EditResultType.delete, null));
              },
        child: Text(
          "Delete",
          style: TextStyle(
            color:
                ref.watch(allowDeleteProvider) ? Colors.white : Colors.white30,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
      ),
      OutlinedButton(
        onPressed: () {
          Navigator.of(context)
              .pop(const EditDataResult(EditResultType.cancel, null));
        },
        child: Text(cancel),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(EditDataResult(
              EditResultType.submit, _textEditingController.text));
        },
        child: Text(submit),
      ),
    ]);

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
      actions: actions,
    );
  }
}
