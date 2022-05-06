import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanban_memo/db/dao.dart';

import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/category_list.dart';

class KanbanBoard extends HookConsumerWidget {
  final BoardData boardData;

  KanbanBoard(this.boardData, {Key? key}) : super(key: key);

  final boardMapProvider = FutureProvider.autoDispose
      .family<LinkedHashMap<CategoryData, List<MemoData>>, BoardData>(
          (ref, data) async {
    if (data.isEmpty()) {
      return LinkedHashMap<CategoryData, List<MemoData>>();
    }
    return Dao().boardMap(data);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(boardMapProvider(boardData));

    return map.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (map) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map
                  .map((key, value) => MapEntry(
                        key,
                        CategoryList(
                          categoryData: key,
                          memoData: value,
                        ),
                      ))
                  .values
                  .toList(),
            ),
          );
        });
  }
}
