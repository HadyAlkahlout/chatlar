part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {
  const SettingsLoadRequested();
}

class SettingsLocaleChanged extends SettingsEvent {
  const SettingsLocaleChanged(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

class SettingsThemeModeChanged extends SettingsEvent {
  const SettingsThemeModeChanged(this.mode);

  final Brightness mode;

  @override
  List<Object?> get props => [mode];
}

class SettingsNotificationsToggled extends SettingsEvent {
  const SettingsNotificationsToggled(this.enabled);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}
