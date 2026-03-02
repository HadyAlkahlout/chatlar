import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) {
    return _repository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
