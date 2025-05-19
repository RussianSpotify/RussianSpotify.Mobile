import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/interfaces/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String _baseUrl = '10.17.38.213';
  final int _basePort = 80;
  final String _baseScheme = 'http';

  @override
  Future<bool> login(String email, String password) async {
    final body = {'Email': email, 'Password': password};

    final url = Uri(
      scheme: _baseScheme,
      host: _baseUrl,
      port: _basePort,
      path: "api/auth/login",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Логин успешен
        return true;
      } else {
        // Логин не удался
        return false;
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<bool> register(
    String username,
    String email,
    String password,
    String passwordConfirm,
    String role,
  ) async {
    final body = {
      'UserName': username,
      'Email': email,
      'Password': password,
      'PasswordConfirm': passwordConfirm,
      'Role': role,
    };

    final url = Uri(
      scheme: _baseScheme,
      host: _baseUrl,
      port: _basePort,
      path: "api/auth/register",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Регистрация успешна
        return true;
      } else {
        // Регистрация не удалась
        return false;
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<bool> confirmEmail(String email, String confirmationCode) async {
    final body = {
      'Email': email,
      'EmailVerificationCodeFromUser': confirmationCode,
    };

    final url = Uri(
      scheme: _baseScheme,
      host: _baseUrl,
      port: _basePort,
      path: "api/auth/confirmemail",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Подтверждение почты успешно
        return true;
      } else {
        // Подтверждение почты не удалось
        return false;
      }
    } catch (e) {
      throw Exception('Email confirmation failed: $e');
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    final body = {'Email': email};

    final url = Uri(
      scheme: _baseScheme,
      host: _baseUrl,
      port: _basePort,
      path: "api/auth/resetpassword",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Сброс пароля успешно инициирован
        return true;
      } else {
        // Сброс пароля не удался
        return false;
      }
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  @override
  Future<bool> confirmNewPassword(
    String email,
    String newPassword,
    String newPasswordConfirm,
    String confirmationCode,
  ) async {
    final body = {
      'Email': email,
      'NewPassword': newPassword,
      'NewPasswordConfirm': newPasswordConfirm,
      'ConfirmationCode': confirmationCode,
    };

    final url = Uri(
      scheme: _baseScheme,
      host: _baseUrl,
      port: _basePort,
      path: "api/auth/confirmpasswordreset",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Подтверждение нового пароля успешно
        return true;
      } else {
        // Подтверждение нового пароля не удалось
        return false;
      }
    } catch (e) {
      throw Exception('New password confirmation failed: $e');
    }
  }
}
