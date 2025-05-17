import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  final Function(String) onUsernameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final Function(String) onPasswordConfirmChanged;
  final Function(bool) onRoleToggled;
  final VoidCallback onRegisterPressed;
  final bool isLoading;
  final String? errorMessage;

  const RegisterWidget({
    super.key,
    required this.onUsernameChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onPasswordConfirmChanged,
    required this.onRoleToggled,
    required this.onRegisterPressed,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Username input field
        TextField(
          onChanged: onUsernameChanged,
          decoration: const InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        // Email input field
        TextField(
          onChanged: onEmailChanged,
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        // Password input field
        TextField(
          onChanged: onPasswordChanged,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        // Confirm Password input field
        TextField(
          onChanged: onPasswordConfirmChanged,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        // Error message if passwords don't match or other errors
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        // Role selection switch
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User', style: TextStyle(color: Colors.white)),
            Switch(
              value: false, // Значение роли может быть передано через состояние
              onChanged: onRoleToggled,
            ),
            const Text('Author', style: TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 24),
        // Button with loading indicator
        isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.purple),
              onPressed: onRegisterPressed,
              child: const Text(
                'Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      ],
    );
  }
}
