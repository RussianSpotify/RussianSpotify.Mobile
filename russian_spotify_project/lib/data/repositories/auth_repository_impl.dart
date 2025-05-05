import '../../domain/interfaces/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return email == 'test@example.com' && password == '123456';
  }

  @override
  Future<bool> register(
    String username,
    String email,
    String password,
    String passwordConfirm,
    String role,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> confirmEmail(String email, String confirmationCode) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<String> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return "123456";
  }

  @override
  Future<bool> confirmNewPassword(
    String email,
    String newPassword,
    String newPasswordConfirm,
    String confirmationCode,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
