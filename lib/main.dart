import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/kanban_board.dart';
import 'package:kanban_memo/widget/main_page.dart';
import 'package:kanban_memo/widget/testbed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dao().initialize();
  await Testbed().init();
  // await Testbed().clear();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPage();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.sawarabiGothicTextTheme(),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulHookConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final boardListProvider = FutureProvider<List<BoardData>>((ref) async {
    return Dao().allBoard();
  });

  final boardSelectedProvider =
      StateProvider<BoardData>((ref) => BoardData.empty());

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<BoardData>> boards = ref.watch(boardListProvider);

    return boards.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (boards) {
          List<Widget> cards = [];
          if (boards.isEmpty) {
            cards.add(const Text("Empty"));
          } else {
            for (var v in boards) {
              cards.add(
                ListTile(
                  title: Text(v.title),
                  onTap: () {
                    ref.read(boardSelectedProvider.notifier).state = v;
                  },
                ),
              );
            }
          }

          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                centerTitle: true,
                actions: const [
                  Icon(Icons.add),
                  Icon(Icons.done),
                ],
              ),
              body: KanbanBoard(ref.watch(boardSelectedProvider)),
              drawer: Drawer(
                child: ListView(
                  children: cards,
                ),
              ));
        });
  }
}
