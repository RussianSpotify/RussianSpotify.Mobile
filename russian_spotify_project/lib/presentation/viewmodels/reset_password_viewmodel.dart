import 'package:flutter/material.dart';
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
    final confirmationCode = await _resetPasswordUseCase.resetPassword(email);
    if (context.mounted) {
      _showMessage(context, 'Success', 'Operation completed successfully!');
      Navigator.pushNamed(
        context,
        AppRoutes.login,
        arguments: {
          'email': email,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
          'confirmationCode': confirmationCode,
        },
      );
    }
  }

  void _showMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
