import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/provider/board_providers.dart';
import 'package:kanban_memo/widget/category_list.dart';

class KanbanBoard extends HookConsumerWidget {
  final BoardData boardData;

  const KanbanBoard(this.boardData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(BoardProviders.boardMapProvider);

    return map.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (map) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildList(map, context),
            ),
          );
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
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ),
    );

    List<Widget> list = [];
    list.addAll(map
        .map((key, value) => MapEntry(
              key,
              CategoryList(
                boardData: boardData,
                categoryData: key,
                memoData: value,
              ),
            ))
        .values);
    list.add(addIcon);
    return list;
  }
}
