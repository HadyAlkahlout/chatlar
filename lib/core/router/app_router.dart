import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/chat/presentation/bloc/chats_bloc.dart';
import '../../features/chat/presentation/pages/chats_list_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'shell_scaffold.dart';

GoRouter createAppRouter({
  required AuthBloc authBloc,
  required SettingsBloc settingsBloc,
}) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = authBloc.state;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      if (authState is AuthAuthenticated && isLoggingIn) return '/';
      if (authState is! AuthAuthenticated && authState is! AuthLoading && !isLoggingIn) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => BlocProvider.value(
          value: authBloc,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => BlocProvider.value(
          value: authBloc,
          child: const RegisterPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => ShellScaffold(
          authBloc: authBloc,
          settingsBloc: settingsBloc,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (_, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => sl<ChatsBloc>(),
                child: const ChatsListPage(),
              ),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (_, state) => NoTransitionPage(
              child: const ProfilePage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => BlocProvider.value(
          value: settingsBloc,
          child: const SettingsPage(),
        ),
      ),
    ],
  );
}