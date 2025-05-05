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

    final route = ModalRoute.of(context);
    if (route == null || route.settings.arguments is! Map<String, String>) {
      _showMessage(context, 'Error', 'Некорректные аргументы при переходе.');
      return;
    }

    final arguments = route.settings.arguments as Map<String, String>;

    final email = arguments['email'];
    final newPassword = arguments['newPassword'];
    final confirmPassword = arguments['confirmPassword'];

    if (email == null || email.isEmpty) {
      _showMessage(context, 'Error', 'Email не указан.');
      return;
    }

    if (operation == 'confirm_email') {
      success = await _confirmUseCase.confirmEmail(email, confirmationCode);
    } else if (operation == 'reset_password') {
      if (newPassword == null || confirmPassword == null) {
        _showMessage(context, 'Error', 'Пароли не указаны.');
        return;
      }

      success = await _confirmUseCase.confirmNewPassword(
        email,
        newPassword,
        confirmPassword,
        confirmationCode,
      );
    }

    if (context.mounted) {
      if (success) {
        _showMessage(context, 'Success', 'Операция выполнена успешно!');
        Navigator.pushNamed(context, AppRoutes.login);
      } else {
        _showMessage(context, 'Error', 'Что-то пошло не так. Попробуйте снова.');
      }
    }
  }


  void _showMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
