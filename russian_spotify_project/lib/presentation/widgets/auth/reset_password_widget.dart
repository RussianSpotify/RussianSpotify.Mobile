import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'New Password',
              isVisible: true,
              onVisibilityToggle: () {},
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'Confirm Password',
              isVisible: true,
              onVisibilityToggle: () {},
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmationCodeController,
              decoration: const InputDecoration(labelText: 'Confirmation Code'),
              style: const TextStyle(color: Colors.white),
            ),
            if (state is AuthError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Получаем значения из текстовых полей
                final email = _emailController.text;
                final newPassword = _newPasswordController.text;
                final confirmPassword = _confirmPasswordController.text;
                final confirmationCode = _confirmationCodeController.text;

                // Проверяем, что все поля заполнены
                if (email.isEmpty ||
                    newPassword.isEmpty ||
                    confirmPassword.isEmpty ||
                    confirmationCode.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                // Проверяем, совпадают ли пароли
                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords don't match")),
                  );
                  return;
                }

                // Вызываем событие подтверждения нового пароля
                context.read<AuthBloc>().add(
                  ConfirmNewPassword(
                    email: email,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword,
                    confirmationCode: confirmationCode,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: state is AuthLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
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