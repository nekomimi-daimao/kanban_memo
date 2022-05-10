import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/provider/config_provider.dart';
import 'package:kanban_memo/widget/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dao().initialize();
  // await Testbed().init();
  // await Testbed().clear();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeModeValue = ref.watch(
        ConfigProvider.configProvider.select((value) => value.themeMode));
    var themeData = ThemeData(
      textTheme: kIsWeb
          ? GoogleFonts.sawarabiGothicTextTheme(Theme.of(context).textTheme)
          : null,
    );
    return MaterialApp(
      title: "kanban memo",
      theme: themeData,
      darkTheme: ThemeData.dark(),
      themeMode: themeModeValue,
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
