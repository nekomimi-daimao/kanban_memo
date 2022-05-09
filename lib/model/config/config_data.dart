import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

part 'config_data.g.dart';

@Collection()
class Config {
  Config({
    this.id = configId,
    required this.themeModeInt,
    required this.categoryListWidth,
  });

  Config.init() {
    id = configId;
    themeMode = ThemeMode.system;
    categoryListWidth = categoryListWidthMin;
  }

  // one and only
  static const configId = 1;

  @Id()
  int? id = configId;

  ThemeMode get themeMode => ThemeMode.values[themeModeInt];

  set themeMode(ThemeMode themeMode) {
    themeModeInt = themeMode.index;
  }

  int themeModeInt = 0;

  double categoryListWidth = categoryListWidthMin;
  static const double categoryListWidthMin = 200;
  static const double categoryListWidthMax = 1000;

  Config copyWith({
    int? id,
    int? themeModeInt,
    double? categoryListWidth,
  }) {
    return Config(
      id: id ?? this.id,
      themeModeInt: themeModeInt ?? this.themeModeInt,
      categoryListWidth: categoryListWidth ?? this.categoryListWidth,
    );
  }

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
