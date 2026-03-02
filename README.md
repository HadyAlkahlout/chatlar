# Chatlar

A WhatsApp-style Flutter chat app with **clean architecture** (feature-based), **auth**, **API config**, **theming**, and **multilanguage** (EN/AR).

## Structure

- **`lib/core/`** – API client (Dio), DI (get_it), router (go_router), theme, l10n
- **`lib/features/auth/`** – Login, register, token storage, AuthBloc
- **`lib/features/chat/`** – Chats list, ChatsBloc (ready for messages when API exists)
- **`lib/features/profile/`** – Profile screen (user info, logout)
- **`lib/features/settings/`** – Language, theme (light/dark), notifications, about/privacy

## API configuration

- Base URL and auth endpoints are in **`lib/core/constants/api_constants.dart`**.
- Override at build time:  
  `flutter run --dart-define=API_BASE_URL=https://your-api.com/v1`
- The app uses a single **Dio** client with auth and log interceptors (see **`lib/core/network/api_client.dart`**).

## Theming

- **`lib/core/theme/app_theme.dart`** – Light and dark Material 3 themes (WhatsApp-like teal primary).
- User choice (light / dark / system) is stored and applied via **SettingsBloc**.

## Multilanguage

- **English** and **Arabic** in **`lib/core/l10n/`** (`.arb` files).
- Regenerate after editing: `flutter gen-l10n`
- Language is selectable in **Settings** and persisted.

## Running

```bash
flutter pub get
flutter run
```

Without a real backend, login/register will fail with a network error. Point **`ApiConstants.baseUrl`** (or the `API_BASE_URL` define) to your chat API when ready.

## Auth flow

- **Login** and **Register** call the remote API and store tokens in **SharedPreferences**.
- **AuthBloc** checks auth on startup; unauthenticated users are redirected to **Login**.
- **Profile** shows current user and **Log out**; **Settings** is available from the profile screen.
