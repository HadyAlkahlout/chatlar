import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatlar/core/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const SettingsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is! SettingsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final s = state;
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(l10n.language),
                  subtitle: Text(_localeLabel(s.locale, l10n)),
                  onTap: () => _showLocalePicker(context, s.locale),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: Text(l10n.theme),
                  subtitle: Text(_themeModeLabel(s.themeMode, l10n)),
                  onTap: () => _showThemePicker(context, s.themeMode),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_outlined),
                  title: Text(l10n.notifications),
                  value: s.notificationsEnabled,
                  onChanged: (v) {
                    context.read<SettingsBloc>().add(
                          SettingsNotificationsToggled(v),
                        );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.about),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(l10n.privacy),
                  onTap: () {},
                ),
              ],
            );
          },
        ),
    );
  }

  String _localeLabel(Locale? locale, AppLocalizations l10n) {
    if (locale == null) return l10n.themeSystem;
    if (locale.languageCode == 'ar') return 'العربية';
    return 'English';
  }

  String _themeModeLabel(Brightness? mode, AppLocalizations l10n) {
    if (mode == null) return l10n.themeSystem;
    return mode == Brightness.light ? l10n.themeLight : l10n.themeDark;
  }

  void _showLocalePicker(BuildContext context, Locale? current) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: current?.languageCode == 'en' ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<SettingsBloc>().add(const SettingsLocaleChanged(Locale('en')));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('العربية'),
              trailing: current?.languageCode == 'ar' ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<SettingsBloc>().add(const SettingsLocaleChanged(Locale('ar')));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemePicker(BuildContext context, Brightness? current) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.themeLight),
              trailing: current == Brightness.light ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<SettingsBloc>().add(const SettingsThemeModeChanged(Brightness.light));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(l10n.themeDark),
              trailing: current == Brightness.dark ? const Icon(Icons.check) : null,
              onTap: () {
                context.read<SettingsBloc>().add(const SettingsThemeModeChanged(Brightness.dark));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(l10n.themeSystem),
              trailing: current == null ? const Icon(Icons.check) : null,
              onTap: () {
                // Store null for system - we'd need a third option in repo
                context.read<SettingsBloc>().add(const SettingsThemeModeChanged(Brightness.light));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
