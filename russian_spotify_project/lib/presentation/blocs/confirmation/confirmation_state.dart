abstract class ConfirmationState {}

class ConfirmationInitial extends ConfirmationState {}

class ConfirmationLoading extends ConfirmationState {}

class ConfirmationLoaded extends ConfirmationState {
  final String email;
  final String? newPassword;
  final String? confirmPassword;
  final String operation;
  final String confirmationCode;

  ConfirmationLoaded({
    required this.email,
    this.newPassword,
    this.confirmPassword,
    required this.operation,
    required this.confirmationCode,
  });
}

class ConfirmationError extends ConfirmationState {
  final String message;

  ConfirmationError(this.message);
}

class ConfirmationSuccess extends ConfirmationState {}
