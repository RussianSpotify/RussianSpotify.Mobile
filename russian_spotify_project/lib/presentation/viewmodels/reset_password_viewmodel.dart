// lib/presentation/viewmodels/reset_password_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:russian_spotify_project/domain/usecases/reset_password_usecase.dart';

import '../../core/utils/app_routes.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ResetPasswordUseCase _resetPasswordUseCase;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isPasswordsMatching = true;
  String _email = '';
  String _newPassword = '';
  String _confirmPassword = '';

  ResetPasswordViewModel(this._resetPasswordUseCase);

  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isPasswordsMatching => _isPasswordsMatching;

  void updateEmail(String email) {
    email = email;
    notifyListeners();
  }

  void updateNewPassword(String password) {
    _newPassword = password;
    validatePasswords();
    notifyListeners();
  }

  void updateConfirmPassword(String password) {
    _confirmPassword = password;
    validatePasswords();
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

  void validatePasswords() {
    _isPasswordsMatching = _newPassword == _confirmPassword;
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context) async {
    final success = await _resetPasswordUseCase.resetPassword(
      _email,
      _newPassword,
    );
    if (context.mounted) {
      if (success) {
        _showMessage(context, 'Success', 'Operation completed successfully!');
        Navigator.pushNamed(context, AppRoutes.login);
      } else {
        _showMessage(context, 'Error', 'Something went wrong. Try again.');
      }
    }
  }

  void _showMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
