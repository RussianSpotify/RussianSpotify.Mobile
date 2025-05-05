import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/viewmodels/reset_password_viewmodel.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetPasswordViewModel>();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => viewModel.email = value,
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          label: 'New Password',
          isVisible: viewModel.isNewPasswordVisible,
          onVisibilityToggle: viewModel.toggleNewPasswordVisibility,
          onChanged: (value) => viewModel.updateNewPassword(value),
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          label: 'Confirm Password',
          isVisible: viewModel.isConfirmPasswordVisible,
          onVisibilityToggle: viewModel.toggleConfirmPasswordVisibility,
          onChanged: (value) => viewModel.updateConfirmPassword(value),
        ),
        if (!viewModel.isPasswordsMatching)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Passwords don't match",
              style: TextStyle(color: Colors.red),
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed:
              () =>
                  viewModel.isPasswordsMatching
                      ? viewModel.resetPassword(context)
                      : null,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          child: const Text("Reset", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: onVisibilityToggle,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
    );
  }
}
