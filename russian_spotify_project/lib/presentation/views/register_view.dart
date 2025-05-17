import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import 'package:russian_spotify_project/presentation/blocs/register/register_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/register/register_event.dart';
import 'package:russian_spotify_project/presentation/blocs/register/register_state.dart';
import 'package:russian_spotify_project/presentation/widgets/auth/register_widget.dart';
import '../../core/utils/app_routes.dart';
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
                child: BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.confirmation,
                        arguments: {
                          'email': context.read<RegisterBloc>().email,
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
                            context.read<RegisterBloc>().add(
                              UpdateUsername(value),
                            );
                          },
                          onEmailChanged: (value) {
                            context.read<RegisterBloc>().add(
                              UpdateEmail(value),
                            );
                          },
                          onPasswordChanged: (value) {
                            context.read<RegisterBloc>().add(
                              UpdatePassword(value),
                            );
                          },
                          onPasswordConfirmChanged: (value) {
                            context.read<RegisterBloc>().add(
                              UpdatePasswordConfirm(value),
                            );
                          },
                          onRoleToggled: (value) {
                            context.read<RegisterBloc>().add(ToggleRole(value));
                          },
                          isLoading: state is RegisterLoading,
                          errorMessage:
                              state is RegisterFailure
                                  ? state.errorMessage
                                  : null,
                          onRegisterPressed: () {
                            context.read<RegisterBloc>().add(
                              PerformRegistration(),
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
