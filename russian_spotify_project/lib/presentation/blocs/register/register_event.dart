abstract class RegisterEvent {}

class UpdateUsername extends RegisterEvent {
  final String username;

  UpdateUsername(this.username);
}

class UpdateEmail extends RegisterEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdatePassword extends RegisterEvent {
  final String password;

  UpdatePassword(this.password);
}

class UpdatePasswordConfirm extends RegisterEvent {
  final String passwordConfirm;

  UpdatePasswordConfirm(this.passwordConfirm);
}

class ToggleRole extends RegisterEvent {
  final bool isAuthor;

  ToggleRole(this.isAuthor);
}

class PerformRegistration extends RegisterEvent {}
