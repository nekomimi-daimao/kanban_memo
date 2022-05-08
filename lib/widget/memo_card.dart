import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_memo.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';

class MemoCard extends HookConsumerWidget {
  final MemoData memoData;

  MemoCard({Key? key, required this.memoData}) : super(key: key);

  @override
  Key? get key => Key(memoData.id.toString());

  final visibleStateProvider = AutoDisposeStateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var view = Visibility(
      child: buildCard(context),
      visible: ref.watch(visibleStateProvider),
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
    );

    return Draggable(
      data: memoData,
      child: view,
      childWhenDragging: view,
      feedback: const Icon(
        Icons.abc,
        size: 40,
      ),
      onDragStarted: () {
        ref.read(visibleStateProvider.notifier).state = false;
      },
      onDragEnd: (d) {
        ref.read(visibleStateProvider.notifier).state = true;
      },
    );
  }

  Card buildCard(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          _editMemo(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                memoData.title,
                maxLines: 1,
              ),
              Text(
                memoData.memo,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _editMemo(BuildContext context) async {
    var editResult = await EditMemoDialog.show(context, memoData);
    if (editResult == null) {
      return;
    }
    switch (editResult) {
      case EditResultType.cancel:
        // Nothing
        break;
      case EditResultType.submit:
        Dao().putMemo(memoData);
        break;
      case EditResultType.delete:
        Dao().deleteMemo(memoData);
        break;
    }
  }
}
