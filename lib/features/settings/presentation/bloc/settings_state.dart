part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    this.locale,
    this.themeMode,
    this.notificationsEnabled = true,
  });

  final Locale? locale;
  final Brightness? themeMode;
  final bool notificationsEnabled;

  SettingsLoaded copyWith({
    Locale? locale,
    Brightness? themeMode,
    bool? notificationsEnabled,
  }) {
    return SettingsLoaded(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object?> get props => [locale, themeMode, notificationsEnabled];
}
