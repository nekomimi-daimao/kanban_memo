import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/provider/board_providers.dart';
import 'package:kanban_memo/widget/category_list.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_text.dart';
import 'package:kanban_memo/widget/dialog/dialog_sort_category.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';
import 'package:kanban_memo/widget/util/extension_widget.dart';

class KanbanBoard extends HookConsumerWidget {
  final BoardData boardData;

  const KanbanBoard(this.boardData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(BoardProviders.boardMapProvider);

    return map.when(
        loading: () => const CircularProgressIndicator().center(),
        error: (err, stack) => Text("$err \n Chrome plz!").center(),
        data: (map) {
          if (!boardData.isEmpty()) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildList(map, context),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/dashboard.svg",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "kanban_board",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ).center();
          }
        });
  }

  List<Widget> _buildList(
      LinkedHashMap<CategoryData, List<MemoData>> map, BuildContext context) {
    var addIcon = Center(
      child: Ink(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.add_box_rounded),
          iconSize: 40,
          onPressed: () async {
            var builder = EditTextDialog.builder("Add Category");
            builder.submit = "Create";
            var categoryName = await builder.build().show(context);
            if (categoryName == null || categoryName.isEmpty) {
              return;
            }
            var newCategory = CategoryData.create(boardData, categoryName);
            await Dao().putCategory(newCategory);
          },
        ),
      ),
    );

    List<Widget> list = [];
    if (boardData.isEmpty()) {
      list.add(addIcon);
    } else {
      for (int index = 0; index < map.keys.length; index += 1) {
        final key = map.keys.elementAt(index);
        final value = map.values.elementAt(index);
        final categoryList = CategoryList(
          boardData: boardData,
          categoryData: key,
          memoData: value,
          isOdd: index.isOdd,
        );
        list.add(categoryList);
      }

      var sortIcon = Ink(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.sort_rounded),
          iconSize: 40,
          onPressed: () async {
            var sortCategoryDialog =
                SortCategoryDialog.create(map.keys.toList());
            var sort = await sortCategoryDialog.show(context);
            if (sort == null) {
              return;
            }
            switch (sort) {
              case EditResultType.submit:
                Dao().putAllCategory(sortCategoryDialog.categoryData);
                break;
              case EditResultType.cancel:
              case EditResultType.delete:
                break;
            }
          },
        ),
      );

      list.add(
        Stack(
          children: [
            addIcon,
            Positioned(top: 40, child: sortIcon),
          ],
        ),
      );
    }

    return list;
  }
}
