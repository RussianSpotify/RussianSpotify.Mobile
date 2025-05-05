import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/app_routes.dart';

import '../../domain/usecases/confirm_usecase.dart';

class ConfirmationViewModel extends ChangeNotifier {
  final ConfirmUseCase _confirmUseCase;

  ConfirmationViewModel(this._confirmUseCase);

  String confirmationCode = '';
  String email = '';
  String operation = '';
  String errorMessage = '';

  void updateConfirmationCode(String value) {
    confirmationCode = value;
    notifyListeners();
  }

  Future<void> handleConfirmClick(BuildContext context) async {
    bool success = false;

    if (operation == 'confirm_email') {
      success = await _confirmUseCase.confirmEmail(email, confirmationCode);
    } else if (operation == 'reset_password') {
      success = await _confirmUseCase.confirmNewPassword(
        email,
        confirmationCode,
        newPassword,
        newPasswordConfirm,
      );
    }

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
