import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/reset_password_usecase.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  String _email = '';
  String _newPassword = '';
  String _confirmPassword = '';
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  ResetPasswordBloc(this._resetPasswordUseCase)
    : super(ResetPasswordInitial()) {
    on<UpdateEmail>(_updateEmail);
    on<UpdateNewPassword>(_updateNewPassword);
    on<UpdateConfirmPassword>(_updateConfirmPassword);
    on<ToggleNewPasswordVisibility>(_toggleNewPasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_toggleConfirmPasswordVisibility);
    on<PerformResetPassword>(_performResetPassword);
  }

  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void _updateEmail(UpdateEmail event, Emitter<ResetPasswordState> emit) {
    _email = event.email;
  }

  void _updateNewPassword(
    UpdateNewPassword event,
    Emitter<ResetPasswordState> emit,
  ) {
    _newPassword = event.newPassword;
  }

  void _updateConfirmPassword(
    UpdateConfirmPassword event,
    Emitter<ResetPasswordState> emit,
  ) {
    _confirmPassword = event.confirmPassword;
  }

  void _toggleNewPasswordVisibility(
    ToggleNewPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    emit(ResetPasswordInitial());
  }

  void _toggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    emit(ResetPasswordInitial());
  }

  Future<void> _performResetPassword(
    PerformResetPassword event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (_newPassword != _confirmPassword) {
      emit(ResetPasswordFailure("Passwords don't match"));
      return;
    }

    emit(ResetPasswordLoading());

    try {
      final success = await _resetPasswordUseCase.resetPassword(_email);

      if (success) {
        emit(ResetPasswordSuccess());
      } else {
        emit(
          ResetPasswordFailure("Failed to reset password. Please try again."),
        );
      }
    } catch (e) {
      emit(ResetPasswordFailure("An error occurred: $e"));
    }
  }
}
