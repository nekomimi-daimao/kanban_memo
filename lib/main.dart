import 'package:flutter/material.dart';
import 'package:kanban_memo/memo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
            MemoList(category: "category", data: []),
          ],
        ),
      )),
    );
  }
}
