import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanban_memo/db/dao.dart';
import 'package:kanban_memo/model/config/config_data.dart';

class ConfigProvider {
  static final StateProvider<Config> configProvider =
      StateProvider<Config>((ref) => Config.init());

  static final FutureProvider<Config?> restoreConfigProvider =
      FutureProvider<Config?>((ref) async {
    return Dao().config();
  });
}
