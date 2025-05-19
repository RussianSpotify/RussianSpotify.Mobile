import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_event.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import '../widgets/auth/header_widget.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({super.key});

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  final TextEditingController _confirmationCodeController = TextEditingController();
  String? _email;

  @override
  void initState() {
    super.initState();
    // Получаем email из параметров маршрута
    final route = ModalRoute.of(context);
    final arguments = route?.settings.arguments as Map<String, String>?;
    _email = arguments?['email'];
  }

  @override
  void dispose() {
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  // Обработка навигации при успешном подтверждении
                  if (state is Authenticated) {
                    Navigator.pushReplacementNamed(context, '/login');
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
                    // Инициализация данных из контекста
                    return _buildConfirmationForm(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Please enter the confirmation code sent to your email.',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _confirmationCodeController,
          decoration: const InputDecoration(
            labelText: 'Confirmation Code',
            labelStyle: TextStyle(color: Colors.white),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final confirmationCode = _confirmationCodeController.text;

            if (_email == null || confirmationCode.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
              );
              return;
            }

            // Вызываем событие подтверждения через AuthBloc
            context.read<AuthBloc>().add(
              ConfirmEmail(
                email: _email!,
                confirmationCode: confirmationCode,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}