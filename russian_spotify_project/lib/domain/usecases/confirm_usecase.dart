import '../interfaces/auth_repository.dart';

class ConfirmUseCase {
  final AuthRepository _authRepository;

  ConfirmUseCase(this._authRepository);

  Future<bool> confirmEmail(String email, String confirmationCode) async {
    return await _authRepository.confirmEmail(email, confirmationCode);
  }

  Future<bool> confirmNewPassword(
    String email,
    String newPassword,
    String newPasswordConfirm,
    String confirmationCode,
  ) async {
    return await _authRepository.confirmNewPassword(
      email,
      newPassword,
      newPasswordConfirm,
      confirmationCode,
    );
  }
}
