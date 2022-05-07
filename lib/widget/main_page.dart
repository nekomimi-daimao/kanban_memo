import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/widget/kanban_board.dart';

class MainPage extends HookConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  final boardListProvider = FutureProvider<List<BoardData>>((ref) async {
    return Dao().allBoard();
  });

  final boardSelectedProvider =
      StateProvider<BoardData>((ref) => BoardData.empty());

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "kanban memo",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.sawarabiGothicTextTheme(),
      ),
      home: _loadWait(ref),
    );
  }

  Widget _loadWait(WidgetRef ref) {
    AsyncValue<List<BoardData>> boards = ref.watch(boardListProvider);
    return boards.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (boards) {
        List<Widget> drawerItem = _createDrawerItem(ref, boards);
        return _createScaffold(ref, drawerItem);
      },
    );
  }

  Scaffold _createScaffold(WidgetRef ref, List<Widget> drawerItem) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(boardSelectedProvider).title),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings_applications_rounded),
        ],
      ),
      body: KanbanBoard(ref.watch(boardSelectedProvider)),
      drawer: Drawer(
        child: ListView(
          children: drawerItem,
        ),
      ),
    );
  }

  List<Widget> _createDrawerItem(WidgetRef ref, List<BoardData> boards) {
    List<Widget> drawerItem = [];
    if (boards.isEmpty) {
      drawerItem.add(const Text("No Board"));
    } else {
      for (var v in boards) {
        drawerItem.add(
          ListTile(
            title: Text(v.title),
            onTap: () {
              ref.read(boardSelectedProvider.notifier).state = v;
            },
          ),
        );
      }
    }

    var addTile = ListTile(
      key: const Key("add"),
      title: const Icon(Icons.add_box_rounded),
      onTap: () async {
        var boardName = await _addBoardDialog();
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

  Future<String?> _addBoardDialog() async {
    var textEditingController = TextEditingController();

    var inputResult = await showDialog<String>(
      context: _buildContext,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Board"),
          content: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Empty!";
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text);
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
    return inputResult;
  }
}
