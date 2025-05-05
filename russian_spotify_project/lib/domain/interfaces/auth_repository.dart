abstract class AuthRepository {
  Future<bool> login(String email, String password);
  Future<bool> register(
    String username,
    String email,
    String password,
    String passwordConfirm,
    String role,
  );
  Future<String> resetPassword(String email);

  Future<bool> confirmEmail(String email, String confirmationCode);
  Future<bool> confirmNewPassword(
    String email,
    String newPassword,
    String newPasswordConfirm,
    String confirmationCode,
  );
}
