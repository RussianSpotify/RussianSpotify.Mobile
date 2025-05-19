import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_event.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import '../../core/utils/app_routes.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/auth/header_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthForm(
                          onEmailChanged: (email) {
                            _emailController.text = email;
                          },
                          onPasswordChanged: (password) {
                            _passwordController.text = password;
                          },
                          onLoginPressed: () {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            if (email.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                              return;
                            }

                            // Вызываем событие входа через AuthBloc
                            context.read<AuthBloc>().add(
                              LoggedIn(email: email, password: password),
                            );
                          },
                          isLoading: state is AuthLoading,
                          errorMessage:
                          state is AuthError ? state.message : null,
                        ),
                        const SizedBox(height: 150),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text(
                              "Sign up for Spotify",
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