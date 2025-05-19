import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_event.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import '../../core/utils/app_routes.dart';
import '../widgets/auth/register_widget.dart';
import '../widgets/auth/header_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 0),
              child: const Header(),
            ),
            const SizedBox(height: 100),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authenticated) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.confirmation,
                        arguments: {
                          'email': '', // TODO: Получить email из текстового поля
                          'operation': ConfirmOperationsConstants.confirmEmail,
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RegisterWidget(
                          onUsernameChanged: (value) {
                            // Сохраняем username для регистрации
                          },
                          onEmailChanged: (value) {
                            // Сохраняем email для регистрации
                          },
                          onPasswordChanged: (value) {
                            // Сохраняем пароль для регистрации
                          },
                          onPasswordConfirmChanged: (value) {
                            // Сохраняем подтверждение пароля для регистрации
                          },
                          onRoleToggled: (value) {
                            // Сохраняем роль пользователя
                          },
                          isLoading: state is AuthLoading,
                          errorMessage:
                          state is AuthError ? state.message : null,
                          onRegisterPressed: () {
                            final username = ''; // TODO: Получить username из текстового поля
                            final email = ''; // TODO: Получить email из текстового поля
                            final password = ''; // TODO: Получить пароль из текстового поля
                            final confirmPassword = ''; // TODO: Получить подтверждение пароля из текстового поля
                            final isAuthor = false; // TODO: Получить роль из переключателя

                            // Вызываем событие регистрации через AuthBloc
                            context.read<AuthBloc>().add(
                              Registered(
                                username: username,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                                isAuthor: isAuthor,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              "Log in to Spotify",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}