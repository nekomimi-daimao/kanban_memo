import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/db/db_to_json.dart';
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
      loading: () => const CircularProgressIndicator().center().emptyScaffold(),
      error: (err, stack) => Text('Error: $err').emptyScaffold(),
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
                      _editBoard(ref, context,
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
      var drawerHeader = DrawerHeader(
        child: const Text(
          "No Board",
          textAlign: TextAlign.center,
        ).center(),
      );
      drawerItem.addAll(drawerHeader.divider());
    } else {
      var titleTile = ListTile(
        title: const Text(
          "Boards",
          textAlign: TextAlign.center,
        ).center(),
      );
      drawerItem.addAll(titleTile.divider());

      for (var v in boards) {
        drawerItem.add(
          ListTile(
            title: Text(
              v.title,
            ).padding(
              const EdgeInsets.only(left: 20),
            ),
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

    var titleTile = ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.settings_applications_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        "Setting",
        textAlign: TextAlign.center,
      ),
    );

    drawerItem.addAll(titleTile.divider());

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
        ListTile(
          title: const Text(
            "CategoryWidth",
            textAlign: TextAlign.center,
          ).center(),
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
        ListTile(
          title: const Text(
            "Theme",
            textAlign: TextAlign.center,
          ).center(),
        ),
        themeDropDown,
      ],
    );

    drawerItem.addAll(themeColumn.divider());

    var jsonTile = ListTile(
      title: const Text(
        "Import / Export",
        textAlign: TextAlign.center,
      ).center(),
    );
    drawerItem.add(jsonTile);

    var importTile = ListTile(
      leading: const Icon(Icons.file_upload_rounded),
      title: const Text(
        "Import",
      ),
      onTap: () async {
        var file = await FilePicker.platform.pickFiles(
          dialogTitle: "Import Json",
          type: FileType.custom,
          allowedExtensions: ["json"],
          withData: true,
        );

        if (file == null || file.files.isEmpty) {
          return;
        }
        var bytes = file.files.first.bytes;
        if (bytes == null) {
          return;
        }
        var json = utf8.decode(bytes);
        Map<String, dynamic> decoded = jsonDecode(json);
        await Dao().importJson(decoded);
      },
    );
    drawerItem.add(importTile);

    var exportTile = ListTile(
      leading: const Icon(Icons.file_download_rounded),
      title: const Text(
        "Export",
      ),
      onTap: () async {
        var json = await Dao().exportJson();
        DbToJson.export(json);
      },
    );
    drawerItem.addAll(exportTile.divider());

    final packageInfo = ref.read(ConfigProvider.packageInfoProvider).value;
    final about = AboutListTile(
      icon: const Icon(Icons.info_outline_rounded),
      applicationName: packageInfo?.appName,
      applicationVersion: packageInfo?.version,
      applicationIcon: SvgPicture.asset(
        "assets/dashboard.svg",
        width: 40,
        height: 40,
      ),
      applicationLegalese: '2022 NekomimiDaimao',
      aboutBoxChildren: [
        const SizedBox(
          height: 10,
        ),
        TextButton(
          child: const Text("github"),
          onPressed: () {
            launchUrlString("https://github.com/nekomimi-daimao/kanban_memo");
          },
        ),
        TextButton(
          child: const Text("@CatEarEvilKing"),
          onPressed: () {
            // https://twitter.com/CatEarEvilKing
            launchUrlString("https://twitter.com/CatEarEvilKing");
          },
        ),
      ],
    );
    drawerItem.add(about);

    return drawerItem;
  }

  Future _editBoard(
      WidgetRef ref, BuildContext context, BoardData boardData) async {
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
        ref.read(BoardProviders.boardSelectedProvider.notifier).state =
            BoardData.empty();
        break;
    }
  }
}
