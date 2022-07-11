import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

class SortCategoryDialog extends StatefulWidget {
  final List<CategoryData> categoryData;

  const SortCategoryDialog.create(this.categoryData, {Key? key})
      : super(key: key);

  @override
  State<SortCategoryDialog> createState() => _SortCategoryDialogState();

  Future<EditResultType?> show(BuildContext context) {
    return showDialog<EditResultType>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return this;
        });
  }
}

class _SortCategoryDialogState extends State<SortCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    var list = ReorderableListView(
        shrinkWrap: true,
        children: widget.categoryData
            .map((e) => ListTile(
                  key: Key('$e.id'),
                  title: Text(e.category),
                ))
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          setState(() {
            var item = widget.categoryData.removeAt(oldIndex);
            widget.categoryData.insert(newIndex, item);
          });
        });

    return AlertDialog(
      title: const Text("Sort Category"),
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
            widget.categoryData
                .whereNotNull()
                .toList()
                .asMap()
                .forEach((key, value) {
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
