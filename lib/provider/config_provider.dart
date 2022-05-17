import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:kanban_memo/model/config/config_data.dart';

class ConfigProvider {
  static final StateProvider<Config> configProvider =
      StateProvider<Config>((ref) => Config.init());

  static final FutureProvider<PackageInfo?> packageInfoProvider =
      FutureProvider<PackageInfo?>((ref) async {
    return PackageInfo.fromPlatform();
  });
}
