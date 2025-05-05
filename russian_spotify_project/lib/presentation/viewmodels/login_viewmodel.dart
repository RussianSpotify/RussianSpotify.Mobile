import 'package:flutter/cupertino.dart';

import '../../domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  String email = '';
  String password = '';
  String? errorMessage;
  bool isLoading = false;
  bool isLoggedIn = false;

  LoginViewModel(this._loginUseCase);

  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'Please enter both email and password.';
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      isLoggedIn = await _loginUseCase.call(email, password);
      if (isLoggedIn) {
        errorMessage = null;
      } else {
        errorMessage = 'Invalid email or password.';
      }
    } catch (e) {
      errorMessage = 'An error occurred while logging in.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
