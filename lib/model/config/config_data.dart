import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

part 'config_data.g.dart';

@Collection()
class Config {
  @Id()
  int? id;

  ThemeMode get themeMode => ThemeMode.values[themeModeInt];

  set themeMode(ThemeMode themeMode) {
    themeModeInt = themeMode.index;
  }

  int themeModeInt = 0;

  int categoryListWidth = 200;

  @override
  String toString() {
    return 'Config{themeModeInt: $themeModeInt, categoryListWidth: $categoryListWidth}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Config &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          themeModeInt == other.themeModeInt &&
          categoryListWidth == other.categoryListWidth;

  @override
  int get hashCode =>
      id.hashCode ^ themeModeInt.hashCode ^ categoryListWidth.hashCode;
}
