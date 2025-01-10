import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'settings.mapper.dart';

class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(Object value) {
    return ThemeMode.values[value as int];
  }

  @override
  Object? encode(ThemeMode self) {
    return self.index;
  }
}

@MappableClass(includeCustomMappers: [ThemeModeMapper()])
class SettingsModel with SettingsModelMappable {
  final ThemeMode themeMode;

  SettingsModel([
    this.themeMode = ThemeMode.system,
  ]);


  static const fromJson = SettingsModelMapper.fromJson;
  static const fromJsonString = SettingsModelMapper.fromJsonString;
}
