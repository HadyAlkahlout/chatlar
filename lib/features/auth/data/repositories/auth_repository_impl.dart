import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDatasource remote,
    required AuthLocalDatasource local,
    required ApiClient apiClient,
  })  : _remote = remote,
        _local = local,
        _apiClient = apiClient;

  final AuthRemoteDatasource _remote;
  final AuthLocalDatasource _local;
  final ApiClient _apiClient;

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final result = await _remote.login(email, password);
      await _local.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      await _local.saveUserId(result.user.id);
      _apiClient.setAccessToken(result.accessToken);
      return result.user;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      final result = await _remote.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      await _local.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      await _local.saveUserId(result.user.id);
      _apiClient.setAccessToken(result.accessToken);
      return result.user;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    await _local.clearAll();
    _apiClient.setAccessToken(null);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final token = await _local.getAccessToken();
    if (token == null || token.isEmpty) return null;
    try {
      _apiClient.setAccessToken(token);
      final user = await _remote.getMe();
      return user;
    } on DioException {
      await _local.clearAll();
      _apiClient.setAccessToken(null);
      return null;
    }
  }

  @override
  Stream<bool> get isAuthenticated async* {
    final token = await _local.getAccessToken();
    yield token != null && token.isNotEmpty;
  }

  Exception _mapDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      return Exception('Invalid email or password');
    }
    if (e.response?.data is Map && (e.response!.data as Map).containsKey('message')) {
      return Exception((e.response!.data as Map)['message'] as String);
    }
    return Exception(e.message ?? 'Network error');
  }
}
