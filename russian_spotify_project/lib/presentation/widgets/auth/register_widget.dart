import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/register_viewmodel.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Column(
      children: [
        // Username input field
        TextField(
          onChanged: viewModel.updateUsername,
          decoration: const InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: Colors.white), // Стилизация лейбла
          ),
          style: const TextStyle(color: Colors.white), // Цвет текста
        ),
        // Email input field
        TextField(
          onChanged: viewModel.updateEmail,
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white), // Стилизация лейбла
          ),
          style: const TextStyle(color: Colors.white), // Цвет текста
        ),
        // Password input field
        TextField(
          onChanged: viewModel.updatePassword,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white), // Стилизация лейбла
          ),
          style: const TextStyle(color: Colors.white), // Цвет текста
        ),
        // Confirm Password input field
        TextField(
          onChanged: viewModel.updatePasswordConfirm,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: Colors.white), // Стилизация лейбла
          ),
          style: const TextStyle(color: Colors.white), // Цвет текста
        ),
        // Error message if passwords don't match
        if (!viewModel.passwordsMatch)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Passwords don't match",
              style: TextStyle(color: Colors.red),
            ),
          ),
        // Role selection switch
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'User',
              style: TextStyle(color: Colors.white), // Стилизация текста
            ),
            Switch(value: viewModel.isAuthor, onChanged: viewModel.toggleRole),
            const Text(
              'Author',
              style: TextStyle(color: Colors.white), // Стилизация текста
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Button with loading indicator
        if (viewModel.isLoading)
          const CircularProgressIndicator()
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.purple, // Цвет текста кнопки
            ),
            onPressed: () async => await viewModel.register(context),
            child: const Text(
              'Sign Up',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
