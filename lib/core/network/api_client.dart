import 'package:dio/dio.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/log_interceptor.dart';

/// Configurable API client (Dio) for the app.
/// Register in DI and inject where needed.
class ApiClient {
  ApiClient({
    required String baseUrl,
    String? accessToken,
    BaseOptions? baseOptions,
  }) : _dio = Dio(baseOptions ?? _defaultOptions(baseUrl)) {
    _dio.interceptors.addAll([
      AuthInterceptor(accessToken: accessToken),
      AppLogInterceptor(),
    ]);
  }

  final Dio _dio;
  String? _accessToken;

  Dio get dio => _dio;

  String? get accessToken => _accessToken;

  void setAccessToken(String? token) {
    _accessToken = token;
    _dio.interceptors.removeWhere((i) => i is AuthInterceptor);
    _dio.interceptors.insert(0, AuthInterceptor(accessToken: token));
  }

  static BaseOptions _defaultOptions(String baseUrl) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }
}
