import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import '../../core/utils/app_routes.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  String username = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';
  bool isAuthor = false;
  String errorMessage = '';
  bool isLoading = false;

  bool get passwordsMatch => password == passwordConfirm;

  // Метод для валидации email
  bool get isEmailValid {
    // Простой пример проверки email
    return email.contains('@') && email.contains('.');
  }

  bool get isRegistered => true;

  // Обновление данных пользователя
  void updateUsername(String value) {
    username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updatePasswordConfirm(String value) {
    passwordConfirm = value;
    notifyListeners();
  }

  void toggleRole(bool value) {
    isAuthor = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (!passwordsMatch) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    if (!isEmailValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid email address")));
      return;
    }

    isLoading = true;
    notifyListeners();

    bool success = await _registerUseCase.call(
      username,
      email,
      password,
      passwordConfirm,
      isAuthor ? 'Автор' : 'Пользователь',
    );

    if (context.mounted) {
      isLoading = false;
      notifyListeners();

      if (success) {
        errorMessage = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registered successfully! Check email to confirm."),
          ),
        );

        Navigator.pushNamed(
          context,
          AppRoutes.confirmation,
          arguments: {
            'email': email,
            'operation': ConfirmOperationsConstants.confirmEmail,
          },
        );
      } else {
        errorMessage = "Registration failed. Please try again.";
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }
}
