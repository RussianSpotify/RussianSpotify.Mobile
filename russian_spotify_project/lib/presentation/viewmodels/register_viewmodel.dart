import 'package:flutter/material.dart';
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

  // Логика регистрации
  Future<bool> register() async {
    if (!passwordsMatch) {
      errorMessage = "Passwords don't match";
      notifyListeners();
      return false;
    }

    if (!isEmailValid) {
      errorMessage = "Please enter a valid email address";
      notifyListeners();
      return false;
    }

    // Устанавливаем флаг загрузки
    isLoading = true;
    notifyListeners();

    // Пытаемся зарегистрировать пользователя
    bool success = await _registerUseCase.call(
      username,
      email,
      password,
      passwordConfirm,
      isAuthor ? 'Автор' : 'Пользователь',
    );

    // Останавливаем индикатор загрузки
    isLoading = false;
    notifyListeners();

    if (!success) {
      errorMessage = "Registration failed. Please try again.";
      notifyListeners();
      return false;
    }

    // Успешная регистрация
    errorMessage = '';
    return true;
  }
}
