// lib/presentation/reset_password_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/viewmodels/reset_password_viewmodel.dart';
import '../widgets/auth/header_widget.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetPasswordViewModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Reset Password')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextField(
                    controller:
                        TextEditingController()..text = viewModel._email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => viewModel.updateEmail(value),
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                    controller:
                        TextEditingController()..text = viewModel._newPassword,
                    label: 'New Password',
                    isVisible: viewModel.isNewPasswordVisible,
                    onVisibilityToggle: viewModel.toggleNewPasswordVisibility,
                    onChanged: (value) => viewModel.updateNewPassword(value),
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                    controller:
                        TextEditingController()
                          ..text = viewModel._confirmPassword,
                    label: 'Confirm Password',
                    isVisible: viewModel.isConfirmPasswordVisible,
                    onVisibilityToggle:
                        viewModel.toggleConfirmPasswordVisibility,
                    onChanged:
                        (value) => viewModel.updateConfirmPassword(value),
                  ),
                  if (!viewModel.isPasswordsMatching)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Passwords don't match",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        viewModel.isPasswordsMatching
                            ? viewModel.resetPassword
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Confirm"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: onVisibilityToggle,
        ),
      ),
      style: TextStyle(color: Colors.black),
      onChanged: onChanged,
    );
  }
}
