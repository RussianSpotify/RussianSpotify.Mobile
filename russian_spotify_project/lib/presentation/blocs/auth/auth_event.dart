abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String email;
  final String password;

  LoggedIn({required this.email, required this.password});
}

class Registered extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isAuthor;

  Registered({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isAuthor,
  });
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  ResetPasswordRequested({required this.email});
}

class ConfirmEmail extends AuthEvent {
  final String email;
  final String confirmationCode;

  ConfirmEmail({required this.email, required this.confirmationCode});
}

class ConfirmNewPassword extends AuthEvent {
  final String email;
  final String newPassword;
  final String confirmPassword;
  final String confirmationCode;

  ConfirmNewPassword({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
    required this.confirmationCode,
  });
}

class LoggedOut extends AuthEvent {}