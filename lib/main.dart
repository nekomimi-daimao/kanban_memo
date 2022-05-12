import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/provider/config_provider.dart';
import 'package:kanban_memo/widget/main_page.dart';
import 'package:kanban_memo/widget/util/extension_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

final FutureProvider initialProvider = FutureProvider((ref) async {
  await Dao().initialize();
  final packageInfo = ref.read(ConfigProvider.packageInfoProvider).value;
  var config = ref.read(ConfigProvider.restoreConfigProvider).value;
  if (config != null) {
    ref.read(ConfigProvider.configProvider.notifier).state = config;
  }
});

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var initial = ref.watch(initialProvider);
    return initial.when(
      loading: () => const CircularProgressIndicator().center(),
      error: (err, stack) {
        ref.refresh(initialProvider);
        return const CircularProgressIndicator().center();
      },
      data: (config) {
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
      },
    );
  }
}
