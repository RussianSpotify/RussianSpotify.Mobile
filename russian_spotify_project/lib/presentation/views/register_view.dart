import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_event.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import '../../core/utils/app_routes.dart';
import '../widgets/auth/register_widget.dart';
import '../widgets/auth/header_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Контроллеры для текстовых полей
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isAuthor = false; // Переключатель роли

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                          'email': _emailController.text, // Передаем email из контроллера
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
                            _usernameController.text = value;
                          },
                          onEmailChanged: (value) {
                            _emailController.text = value;
                          },
                          onPasswordChanged: (value) {
                            _passwordController.text = value;
                          },
                          onPasswordConfirmChanged: (value) {
                            _confirmPasswordController.text = value;
                          },
                          onRoleToggled: (value) {
                            setState(() {
                              _isAuthor = value;
                            });
                          },
                          isLoading: state is AuthLoading,
                          errorMessage:
                          state is AuthError ? state.message : null,
                          onRegisterPressed: () {
                            final username = _usernameController.text;
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final confirmPassword = _confirmPasswordController.text;

                            // Проверяем, что все поля заполнены
                            if (username.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill all fields')),
                              );
                              return;
                            }

                            // Проверяем, совпадают ли пароли
                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Passwords don't match")),
                              );
                              return;
                            }

                            // Вызываем событие регистрации через AuthBloc
                            context.read<AuthBloc>().add(
                              Registered(
                                username: username,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                                isAuthor: _isAuthor,
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