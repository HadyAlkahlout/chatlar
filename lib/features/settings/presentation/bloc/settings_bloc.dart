import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._repository) : super(SettingsInitial()) {
    on<SettingsLoadRequested>(_onLoad);
    on<SettingsLocaleChanged>(_onLocaleChanged);
    on<SettingsThemeModeChanged>(_onThemeModeChanged);
    on<SettingsNotificationsToggled>(_onNotificationsToggled);
  }

  final SettingsRepository _repository;

  Future<void> _onLoad(SettingsLoadRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final locale = await _repository.getLocale();
    final themeMode = await _repository.getThemeMode();
    final notifications = await _repository.getNotificationsEnabled();
    emit(SettingsLoaded(
      locale: locale,
      themeMode: themeMode,
      notificationsEnabled: notifications,
    ));
  }

  Future<void> _onLocaleChanged(SettingsLocaleChanged event, Emitter<SettingsState> emit) async {
    await _repository.setLocale(event.locale);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(locale: event.locale));
    }
  }

  Future<void> _onThemeModeChanged(SettingsThemeModeChanged event, Emitter<SettingsState> emit) async {
    await _repository.setThemeMode(event.mode);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(themeMode: event.mode));
    }
  }

  Future<void> _onNotificationsToggled(SettingsNotificationsToggled event, Emitter<SettingsState> emit) async {
    await _repository.setNotificationsEnabled(event.enabled);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(notificationsEnabled: event.enabled));
    }
  }
}
