import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/memo/board_data.dart';
import 'package:kanban_memo/model/memo/memo_data.dart';
import 'package:kanban_memo/widget/memo_card.dart';
import 'package:kanban_memo/widget/testbed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dao().initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  final MemoData data = MemoData(boardId: 0, categoryId: 0);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final boardProvider = FutureProvider<List<BoardData>>((ref) async {
    return Dao().allBoard();
  });

  @override
  Widget build(BuildContext context) {
    // Testbed().init();
    // Testbed().clear();

    AsyncValue<List<BoardData>> boards = ref.watch(boardProvider);

    List<Widget> view = boards.when(
      loading: () => [const Text("Loading")],
      error: (err, stack) => [Text('Error: $err')],
      data: (boards) {
        return boards.map((e) => ListTile(title: Text(e.title))).toList();
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemoCard(data: widget.data),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: view,
          ),
        ));
  }
}
