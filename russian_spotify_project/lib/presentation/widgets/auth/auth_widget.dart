import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_routes.dart';
import '../../viewmodels/login_viewmodel.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Column(
      children: [
        TextField(
          onChanged: (value) => viewModel.email = value,
          decoration: const InputDecoration(labelText: 'Email'),
          style: TextStyle(color: Colors.white),
        ),
        TextField(
          onChanged: (value) => viewModel.password = value,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 24),
        if (viewModel.isLoading)
          const CircularProgressIndicator()
        else
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.purple,
                    ),
                    onPressed: () async {
                      await viewModel.login();

                      if (!context.mounted) return;

                      if (viewModel.isLoggedIn) {
                        Navigator.pushNamed(context, AppRoutes.home);
                      } else {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(
                                  viewModel.errorMessage ?? 'Unknown error',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.resetPassword);
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
