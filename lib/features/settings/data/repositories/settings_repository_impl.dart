import 'dart:ui';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SettingsLocalDatasource local}) : _local = local;

  final SettingsLocalDatasource _local;

  @override
  Future<Locale?> getLocale() => _local.getLocale();

  @override
  Future<void> setLocale(Locale locale) => _local.setLocale(locale);

  @override
  Future<Brightness?> getThemeMode() => _local.getThemeMode();

  @override
  Future<void> setThemeMode(Brightness mode) => _local.setThemeMode(mode);

  @override
  Future<bool> getNotificationsEnabled() => _local.getNotificationsEnabled();

  @override
  Future<void> setNotificationsEnabled(bool value) =>
      _local.setNotificationsEnabled(value);
}
