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
    var card = buildCard(context).visibility(ref.watch(visibleStateProvider));

    var dragTarget = DragTarget(
      builder: (BuildContext context, List<Object?> candidateData,
          List<dynamic> rejectedData) {
        return card;
      },
      onWillAccept: (draggable) {
        if (draggable is! MemoData) {
          return false;
        }
        return draggable != memoData;
      },
      onAccept: (draggable) {
        if (draggable is! MemoData) {
          return;
        }
        var categoryId = memoData.categoryId;
        if (categoryId == null) {
          return;
        }
        Dao().insertMemo(categoryId, draggable, memoData.index);
      },
    );

    return Draggable(
      data: memoData,
      child: dragTarget,
      childWhenDragging: card,
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

extension on Widget {
  Visibility visibility(bool visible) {
    return Visibility(
      child: this,
      visible: visible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
    );
  }
}
