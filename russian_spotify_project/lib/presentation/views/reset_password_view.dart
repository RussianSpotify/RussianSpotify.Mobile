import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import 'package:russian_spotify_project/presentation/widgets/auth/reset_password_widget.dart';
import '../widgets/auth/header_widget.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Reset Password'),
        foregroundColor: Colors.purple,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    // Переход на главный экран после успешного сброса пароля
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AuthError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const ResetPasswordForm();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}