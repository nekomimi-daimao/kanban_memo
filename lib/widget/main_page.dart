import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/provider/board_providers.dart';
import 'package:kanban_memo/widget/kanban_board.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_text.dart';

class MainPage extends HookConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<BoardData>> boards =
        ref.watch(BoardProviders.boardListProvider);
    return boards.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (boards) {
        var drawerItem = _createDrawerItem(ref, context, boards);
        return Scaffold(
          appBar: AppBar(
            title: Text(ref.watch(BoardProviders.boardSelectedProvider).title),
            centerTitle: true,
            actions: const [
              Icon(Icons.settings_applications_rounded),
            ],
          ),
          body: KanbanBoard(ref.watch(BoardProviders.boardSelectedProvider)),
          drawer: Drawer(
            child: ListView(
              children: drawerItem,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _createDrawerItem(
      WidgetRef ref, BuildContext context, List<BoardData> boards) {
    List<Widget> drawerItem = [];
    if (boards.isEmpty) {
      drawerItem.add(const Text(
        "No Board",
        textAlign: TextAlign.center,
      ));
    } else {
      for (var v in boards) {
        drawerItem.add(
          ListTile(
            title: Text(v.title),
            onTap: () {
              ref.read(BoardProviders.boardSelectedProvider.notifier).state = v;
            },
          ),
        );
      }
    }

    var addTile = ListTile(
      key: const Key("add"),
      title: const Icon(Icons.add_box_rounded),
      onTap: () async {
        var builder = EditTextDialog.builder("Add Board");
        builder.submit = "Create";
        var boardName = await builder.build().show(context);
        if (boardName == null || boardName.isEmpty) {
          return;
        }
        var newBoard = BoardData.create(boardName);
        await Dao().putBoard(newBoard);
      },
    );
    drawerItem.add(addTile);

    return drawerItem;
  }
}
