import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import 'package:russian_spotify_project/presentation/blocs/confirmation/confirmation_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/confirmation/confirmation_event.dart';
import 'package:russian_spotify_project/presentation/blocs/confirmation/confirmation_state.dart';
import '../widgets/auth/header_widget.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

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
              child: BlocConsumer<ConfirmationBloc, ConfirmationState>(
                listener: (context, state) {
                  // Обработка навигации при успешном подтверждении
                  if (state is ConfirmationSuccess) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                builder: (context, state) {
                  if (state is ConfirmationInitial) {
                    // Инициализация данных из контекста
                    context.read<ConfirmationBloc>().add(
                      InitializeFromContext(context),
                    );
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConfirmationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConfirmationLoaded) {
                    return _buildConfirmationForm(context, state);
                  } else if (state is ConfirmationError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Unknown state',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationForm(
    BuildContext context,
    ConfirmationLoaded state,
  ) {
    return Column(
      children: [
        Text(
          state.operation == ConfirmOperationsConstants.confirmEmail
              ? 'Please enter the confirmation code sent to your email.'
              : 'Please enter the confirmation code sent to your email to reset your password.',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Confirmation Code',
            labelStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            context.read<ConfirmationBloc>().add(UpdateConfirmationCode(value));
          },
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.read<ConfirmationBloc>().add(HandleConfirmClick(context));
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
