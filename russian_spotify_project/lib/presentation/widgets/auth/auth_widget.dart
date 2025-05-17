import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final VoidCallback onLoginPressed;
  final bool isLoading;
  final String? errorMessage;

  const AuthForm({
    super.key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onLoginPressed,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onEmailChanged,
          decoration: const InputDecoration(labelText: 'Email'),
          style: const TextStyle(color: Colors.white),
        ),
        TextField(
          onChanged: onPasswordChanged,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
          style: const TextStyle(color: Colors.white),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const SizedBox(height: 24),
        if (isLoading)
          const CircularProgressIndicator()
        else
          ElevatedButton(
            onPressed: onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Login'),
          ),
      ],
    );
  }
}
