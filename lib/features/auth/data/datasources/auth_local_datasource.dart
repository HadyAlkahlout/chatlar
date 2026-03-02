import '../../../../core/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  });
  Future<void> saveUserId(String userId);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<String?> getUserId();
  Future<void> clearAll();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  AuthLocalDatasourceImpl({required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _prefs.setString(StorageConstants.accessToken, accessToken);
    if (refreshToken != null) {
      await _prefs.setString(StorageConstants.refreshToken, refreshToken);
    }
  }

  @override
  Future<void> saveUserId(String userId) async {
    await _prefs.setString(StorageConstants.userId, userId);
  }

  @override
  Future<String?> getAccessToken() =>
      Future.value(_prefs.getString(StorageConstants.accessToken));

  @override
  Future<String?> getRefreshToken() =>
      Future.value(_prefs.getString(StorageConstants.refreshToken));

  @override
  Future<String?> getUserId() =>
      Future.value(_prefs.getString(StorageConstants.userId));

  @override
  Future<void> clearAll() async {
    await _prefs.remove(StorageConstants.accessToken);
    await _prefs.remove(StorageConstants.refreshToken);
    await _prefs.remove(StorageConstants.userId);
  }
}
