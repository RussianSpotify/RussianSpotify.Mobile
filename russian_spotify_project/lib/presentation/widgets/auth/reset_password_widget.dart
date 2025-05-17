import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/reset_password/reset_password_state.dart';
import '../../blocs/reset_password/reset_password_bloc.dart';
import '../../blocs/reset_password/reset_password_event.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                context.read<ResetPasswordBloc>().add(UpdateEmail(value));
              },
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'New Password',
              isVisible: context.read<ResetPasswordBloc>().isNewPasswordVisible,
              onVisibilityToggle: () {
                context.read<ResetPasswordBloc>().add(
                  ToggleNewPasswordVisibility(),
                );
              },
              onChanged: (value) {
                context.read<ResetPasswordBloc>().add(UpdateNewPassword(value));
              },
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'Confirm Password',
              isVisible:
                  context.read<ResetPasswordBloc>().isConfirmPasswordVisible,
              onVisibilityToggle: () {
                context.read<ResetPasswordBloc>().add(
                  ToggleConfirmPasswordVisibility(),
                );
              },
              onChanged: (value) {
                context.read<ResetPasswordBloc>().add(
                  UpdateConfirmPassword(value),
                );
              },
            ),
            if (state is ResetPasswordFailure &&
                state.errorMessage == "Passwords don't match")
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Passwords don't match",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ResetPasswordBloc>().add(PerformResetPassword());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child:
                  state is ResetPasswordLoading
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
