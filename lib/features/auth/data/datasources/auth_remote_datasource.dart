import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDatasource {
  Future<({UserModel user, String accessToken, String? refreshToken})> login(
    String email,
    String password,
  );
  Future<({UserModel user, String accessToken, String? refreshToken})> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  });
  Future<UserModel> getMe();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required ApiClient apiClient}) : _api = apiClient;

  final ApiClient _api;

  @override
  Future<({UserModel user, String accessToken, String? refreshToken})> login(
    String email,
    String password,
  ) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    final data = res.data!;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    final accessToken = data['access_token'] as String;
    final refreshToken = data['refresh_token'] as String?;
    return (user: user, accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<({UserModel user, String accessToken, String? refreshToken})> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      ApiConstants.register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        if (phone != null) 'phone': phone,
      },
    );
    final data = res.data!;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    final accessToken = data['access_token'] as String;
    final refreshToken = data['refresh_token'] as String?;
    return (user: user, accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<UserModel> getMe() async {
    final res = await _api.dio.get<Map<String, dynamic>>(ApiConstants.me);
    return UserModel.fromJson(res.data!);
  }
}
