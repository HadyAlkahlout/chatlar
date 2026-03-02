import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatlar/core/l10n/app_localizations.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const ChatlarApp());
}

class ChatlarApp extends StatelessWidget {
  const ChatlarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = sl<AuthBloc>()..add(const AuthCheckRequested());
    final settingsBloc = sl<SettingsBloc>()..add(const SettingsLoadRequested());

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: settingsBloc),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, settingsState) {
          Locale? locale;
          ThemeMode themeMode = ThemeMode.system;
          if (settingsState is SettingsLoaded) {
            locale = settingsState.locale;
            if (settingsState.themeMode != null) {
              themeMode = settingsState.themeMode == Brightness.dark
                  ? ThemeMode.dark
                  : ThemeMode.light;
            }
          }
          return MaterialApp.router(
            title: 'Chatlar',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: createAppRouter(
              authBloc: authBloc,
              settingsBloc: settingsBloc,
            ),
          );
        },
      ),
    );
  }
}
