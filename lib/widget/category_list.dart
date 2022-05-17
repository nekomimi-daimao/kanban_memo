import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/provider/config_provider.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_data.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';
import 'package:kanban_memo/widget/memo_card.dart';

class CategoryList extends HookConsumerWidget {
  const CategoryList(
      {Key? key,
      required this.boardData,
      required this.categoryData,
      required this.memoData,
      required this.isOdd})
      : super(key: key);

  final BoardData boardData;
  final CategoryData categoryData;
  final List<MemoData> memoData;
  final bool isOdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var addTile = ListTile(
      key: const Key("add"),
      title: const Icon(Icons.add_box_rounded),
      onTap: () async {
        var newMemo = MemoData.create(boardData, categoryData);
        var lastIndex = memoData.isNotEmpty ? memoData.last.index : 0;
        newMemo.index = lastIndex + 1;
        memoData.add(newMemo);
        await Dao().putMemo(newMemo);
      },
    );
    var dragTarget = DragTarget(builder: (BuildContext context,
        List<Object?> candidateData, List<dynamic> rejectedData) {
      return addTile;
    }, onWillAccept: (draggable) {
      return draggable is MemoData;
    }, onAccept: (draggable) {
      if (draggable is! MemoData) {
        return;
      }
      var categoryId = categoryData.id;
      if (categoryId == null) {
        return;
      }

      Dao().insertMemo(categoryId, draggable, -1);
    });

    memoData.sort((a, b) => a.index.compareTo(b.index));

    List<Widget> items = [];
    items.addAll(memoData.map((e) => MemoCard(memoData: e)));
    items.add(dragTarget);

    var categoryListWith = ref.watch(ConfigProvider.configProvider
        .select((value) => value.categoryListWidth));

    return Container(
      width: categoryListWith,
      color: Theme.of(context).backgroundColor.withOpacity(isOdd ? 0.15 : 0.05),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            child: Text(
              categoryData.category,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _editCategory(context);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              primary: false,
              children: items,
            ),
          )
        ],
      ),
    );
  }

  Future _editCategory(BuildContext context) async {
    var builder = EditDataDialog.builder("Edit Category");
    builder.initialValue = categoryData.category;
    var edit = await builder.build().show(context);
    if (edit == null) {
      return;
    }
    switch (edit.resultType) {
      case EditResultType.cancel:
        // Nothing
        break;
      case EditResultType.submit:
        categoryData.category = edit.input ?? "";
        Dao().putCategory(categoryData);
        break;
      case EditResultType.delete:
        Dao().deleteCategory(categoryData);
        break;
    }
  }
}
