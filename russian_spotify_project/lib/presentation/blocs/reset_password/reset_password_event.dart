abstract class ResetPasswordEvent {}

class UpdateEmail extends ResetPasswordEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdateNewPassword extends ResetPasswordEvent {
  final String newPassword;

  UpdateNewPassword(this.newPassword);
}

class UpdateConfirmPassword extends ResetPasswordEvent {
  final String confirmPassword;

  UpdateConfirmPassword(this.confirmPassword);
}

class ToggleNewPasswordVisibility extends ResetPasswordEvent {}

class ToggleConfirmPasswordVisibility extends ResetPasswordEvent {}

class PerformResetPassword extends ResetPasswordEvent {}
