import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/config/config_data.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/provider/board_providers.dart';
import 'package:kanban_memo/provider/config_provider.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_data.dart';
import 'package:kanban_memo/widget/dialog/enum/enum_edit_result.dart';
import 'package:kanban_memo/widget/kanban_board.dart';
import 'package:kanban_memo/widget/dialog/dialog_edit_text.dart';
import 'package:kanban_memo/widget/util/extension_widget.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<BoardData>> boards =
        ref.watch(BoardProviders.boardListProvider);
    return boards.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (boards) {
        var drawerItem = _createMemoDrawerItem(ref, context, boards);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ref.watch(BoardProviders.boardSelectedProvider).title),
                if (!ref.watch(BoardProviders.boardSelectedProvider).isEmpty())
                  IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () async {
                      _editBoard(context,
                          ref.read(BoardProviders.boardSelectedProvider));
                    },
                  ),
              ],
            ),
            centerTitle: true,
            actions: [
              Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings_applications_rounded),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              }),
            ],
          ),
          body: KanbanBoard(ref.watch(BoardProviders.boardSelectedProvider)),
          drawer: Drawer(
            child: ListView(
              children: drawerItem,
            ),
          ),
          endDrawer: Drawer(
            child: ListView(
              children: _createSettingsDrawerItem(ref, context),
            ),
          ),
          onEndDrawerChanged: (isOpen) async {
            if (isOpen) {
              var savedConfig = await Dao().config();
              if (savedConfig == null) {
                return;
              }
              ref.read(ConfigProvider.configProvider.notifier).state =
                  savedConfig;
            } else {
              var config = ref.read(ConfigProvider.configProvider);
              Dao().putConfig(config);
            }
          },
        );
      },
    );
  }

  List<Widget> _createMemoDrawerItem(
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

  List<Widget> _createSettingsDrawerItem(WidgetRef ref, BuildContext context) {
    List<Widget> drawerItem = [];

    var sliderValue = ref.watch(ConfigProvider.configProvider
        .select((value) => value.categoryListWidth));
    var categoryWidthSlider = Slider(
      value: sliderValue,
      label: sliderValue.round().toString(),
      min: Config.categoryListWidthMin,
      max: Config.categoryListWidthMax,
      divisions:
          (Config.categoryListWidthMax - Config.categoryListWidthMin) ~/ 20,
      onChanged: (v) {
        ref
            .read(ConfigProvider.configProvider.notifier)
            .update((state) => state.copyWith(categoryListWidth: v));
      },
    );
    var sliderColumn = Column(
      children: [
        const ListTile(
          title: Text("CategoryWidth"),
        ),
        categoryWidthSlider,
      ],
    );

    drawerItem.addAll(sliderColumn.divider());

    var themeModeValue = ref.watch(
        ConfigProvider.configProvider.select((value) => value.themeMode));
    var themeDropDown = DropdownButton<ThemeMode>(
      value: themeModeValue,
      items: ThemeMode.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.toString().split(".").last),
              onTap: null,
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v == null) {
          return;
        }
        FocusManager.instance.primaryFocus?.unfocus();
        ref
            .read(ConfigProvider.configProvider.notifier)
            .update((state) => state.copyWith(themeModeInt: v.index));
      },
    );

    var themeColumn = Column(
      children: [
        const ListTile(
          title: Text("Theme"),
        ),
        themeDropDown,
      ],
    );

    drawerItem.addAll(themeColumn.divider());

    var about = const AboutListTile(
      icon: Icon(Icons.info_outline_rounded),
      // applicationVersion: '1.0.0',
      // applicationIcon: Icon(Icons.wb_incandescent),
      applicationLegalese: '2022 NekomimiDaimao',
      // aboutBoxChildren: [Text("data")],
    );
    drawerItem.add(about);

    return drawerItem;
  }

  Future _editBoard(BuildContext context, BoardData boardData) async {
    var builder = EditDataDialog.builder("Edit Category");
    builder.initialValue = boardData.title;
    var edit = await builder.build().show(context);
    if (edit == null) {
      return;
    }
    switch (edit.resultType) {
      case EditResultType.cancel:
        // Nothing
        break;
      case EditResultType.submit:
        boardData.title = edit.input ?? "";
        Dao().putBoard(boardData);
        break;
      case EditResultType.delete:
        Dao().deleteBoard(boardData);
        break;
    }
  }
}
