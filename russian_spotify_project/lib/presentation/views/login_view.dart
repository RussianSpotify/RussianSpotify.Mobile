import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/login/login_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/login/login_event.dart';
import 'package:russian_spotify_project/presentation/blocs/login/login_state.dart';
import '../../core/utils/app_routes.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/auth/header_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthForm(
                          onEmailChanged: (email) {
                            context.read<LoginBloc>().add(UpdateEmail(email));
                          },
                          onPasswordChanged: (password) {
                            context.read<LoginBloc>().add(
                              UpdatePassword(password),
                            );
                          },
                          onLoginPressed: () {
                            context.read<LoginBloc>().add(PerformLogin());
                          },
                          isLoading: state is LoginLoading,
                          errorMessage:
                              state is LoginFailure ? state.errorMessage : null,
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
