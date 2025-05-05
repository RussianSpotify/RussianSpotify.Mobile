import '../interfaces/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<String> resetPassword(String email) async {
    return await repository.resetPassword(email);
  }
}
