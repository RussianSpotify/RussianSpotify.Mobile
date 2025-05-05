import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/app_routes.dart';

import '../../domain/usecases/confirm_usecase.dart';

class ConfirmationViewModel extends ChangeNotifier {
  final ConfirmUseCase _confirmUseCase;

  ConfirmationViewModel(this._confirmUseCase);

  String? email;
  String? newPassword;
  String? confirmPassword;
  String confirmationCode = '';
  String? operation;
  String errorMessage = '';

  void initFromContext(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null || route.settings.arguments is! Map<String, String>) {
      errorMessage = 'Некорректные аргументы при переходе.';
      notifyListeners();
      return;
    }

    final arguments = route.settings.arguments as Map<String, String>;
    email = arguments['email'];
    newPassword = arguments['newPassword'];
    confirmPassword = arguments['confirmPassword'];
    operation = arguments['operation'];

    notifyListeners();
  }

  void updateConfirmationCode(String value) {
    confirmationCode = value;
    notifyListeners();
  }

  Future<void> handleConfirmClick(BuildContext context) async {
    // TODO: пустые параметры получает
    // bool success = false;
    //
    // if (email == null ||
    //     email!.isEmpty ||
    //     operation == null ||
    //     operation!.isEmpty) {
    //   _showMessage(context, 'Error', 'Необходимые аргументы отсутствуют.');
    // }
    //
    // if (operation == ConfirmOperationsConstants.confirmEmail) {
    //   success = await _confirmUseCase.confirmEmail(email!, confirmationCode);
    // } else if (operation == ConfirmOperationsConstants.resetPassword) {
    //   if (newPassword == null ||
    //       newPassword!.isEmpty ||
    //       confirmPassword == null ||
    //       confirmPassword!.isEmpty) {
    //     _showMessage(context, 'Error', 'Пароли не указаны.');
    //     return;
    //   }
    //
    //   success = await _confirmUseCase.confirmNewPassword(
    //     email!,
    //     newPassword!,
    //     confirmPassword!,
    //     confirmationCode,
    //   );
    // }

    bool success = true;

    if (context.mounted) {
      if (success) {
        _showMessage(context, 'Success', 'Операция выполнена успешно!');
        Navigator.pushNamed(context, AppRoutes.login);
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
