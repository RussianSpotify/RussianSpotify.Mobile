import '../interfaces/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> call(
    String username,
    String email,
    String password,
    String passwordConfirm,
    String role,
  ) async {
    return await repository.register(
      username,
      email,
      password,
      passwordConfirm,
      role,
    );
  }
}
