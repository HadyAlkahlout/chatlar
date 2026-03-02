/// API configuration constants.
/// Replace baseUrl with your actual chat API base URL.
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.chatlar.example.com/v1',
  );

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/users/me';
  static const String chats = '/chats';
  static const String messages = '/messages';
}
