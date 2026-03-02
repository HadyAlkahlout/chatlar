import 'dart:ui';

abstract class SettingsRepository {
  Future<Locale?> getLocale();
  Future<void> setLocale(Locale locale);
  Future<Brightness?> getThemeMode();
  Future<void> setThemeMode(Brightness mode);
  Future<bool> getNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool value);
}
