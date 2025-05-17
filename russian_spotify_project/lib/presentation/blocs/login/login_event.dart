abstract class LoginEvent {}

class InitializeLogin extends LoginEvent {}

class UpdateEmail extends LoginEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdatePassword extends LoginEvent {
  final String password;

  UpdatePassword(this.password);
}

class PerformLogin extends LoginEvent {}
