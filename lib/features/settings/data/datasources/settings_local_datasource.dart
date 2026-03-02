import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/storage_constants.dart';

abstract class SettingsLocalDatasource {
  Future<Locale?> getLocale();
  Future<void> setLocale(Locale locale);
  Future<Brightness?> getThemeMode();
  Future<void> setThemeMode(Brightness mode);
  Future<bool> getNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool value);
}

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  SettingsLocalDatasourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<Locale?> getLocale() async {
    final code = _prefs.getString(StorageConstants.locale);
    if (code == null) return null;
    return Locale(code);
  }

  @override
  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(StorageConstants.locale, locale.languageCode);
  }

  @override
  Future<Brightness?> getThemeMode() async {
    final value = _prefs.getString(StorageConstants.themeMode);
    if (value == null) return null;
    if (value == 'light') return Brightness.light;
    if (value == 'dark') return Brightness.dark;
    return null;
  }

  @override
  Future<void> setThemeMode(Brightness mode) async {
    final value = mode == Brightness.light ? 'light' : 'dark';
    await _prefs.setString(StorageConstants.themeMode, value);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return _prefs.getBool('notifications_enabled') ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool('notifications_enabled', value);
  }
}
