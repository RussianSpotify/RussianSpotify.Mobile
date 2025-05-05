import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/confirmation_viewmodel.dart';
import '../widgets/auth/header_widget.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ConfirmationViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          Header(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  viewModel.operation == 'confirm_email'
                      ? 'Please enter the confirmation code sent to your email.'
                      : 'Please enter the confirmation code sent to your email to reset your password.',
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Confirmation Code'),
                  onChanged: (value) => viewModel.updateConfirmationCode(value),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => viewModel.handleConfirmClick(context),
                  child: Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
