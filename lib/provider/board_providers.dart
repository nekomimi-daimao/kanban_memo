import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/category_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';

class BoardProviders {
  // db streams
  static final boardChangedProvider = StreamProvider((_) {
    return Dao().boardStream();
  });
  static final categoryChangedProvider = StreamProvider((_) {
    return Dao().categoryStream();
  });
  static final memoChangedProvider = StreamProvider((_) {
    return Dao().memoStream();
  });

  static final boardListProvider = FutureProvider<List<BoardData>>((ref) async {
    final changedBoard = ref.watch(boardChangedProvider);
    return Dao().allBoard();
  });

  static final boardSelectedProvider =
      StateProvider<BoardData>((ref) => BoardData.empty());

  static final boardMapProvider = FutureProvider((ref) async {
    final data = ref.watch(boardSelectedProvider);
    final changedBoard = ref.watch(boardChangedProvider);
    final changedCategory = ref.watch(categoryChangedProvider);
    final changedMemo = ref.watch(memoChangedProvider);

    if (data.isEmpty()) {
      // ignore: prefer_collection_literals
      return LinkedHashMap<CategoryData, List<MemoData>>();
    }
    return Dao().boardMap(data);
  });
}
