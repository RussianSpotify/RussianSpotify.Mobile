import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import 'package:russian_spotify_project/domain/usecases/reset_password_usecase.dart';

import '../../core/utils/app_routes.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ResetPasswordUseCase _resetPasswordUseCase;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String email = '';
  String newPassword = '';
  String confirmPassword = '';

  ResetPasswordViewModel(this._resetPasswordUseCase);

  bool get isNewPasswordVisible => _isNewPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  bool get isPasswordsMatching => newPassword == confirmPassword;

  void updateConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void updateNewPassword(String value) {
    newPassword = value;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context) async {
    final success = await _resetPasswordUseCase.resetPassword(email);

    if (context.mounted) {
      if (success) {
        _showMessage(context, 'Success', 'Operation completed successfully!');
        Navigator.pushNamed(
          context,
          AppRoutes.confirmation,
          arguments: {
            'email': email,
            'newPassword': newPassword,
            'confirmPassword': confirmPassword,
            'operation': ConfirmOperationsConstants.resetPassword,
          },
        );
      } else {
        _showMessage(
          context,
          'Error',
          'Что-то пошло не так. Попробуйте снова.',
        );
      }
    }
  }

  void _showMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
