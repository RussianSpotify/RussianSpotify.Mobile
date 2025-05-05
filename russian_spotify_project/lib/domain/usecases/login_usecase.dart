import '../interfaces/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<bool> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}
