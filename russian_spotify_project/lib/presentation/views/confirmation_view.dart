import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/core/utils/confirm_operations_constants.dart';
import '../viewmodels/confirmation_viewmodel.dart';
import '../widgets/auth/header_widget.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({super.key});

  @override
  ConfirmationViewState createState() => ConfirmationViewState();
}

class ConfirmationViewState extends State<ConfirmationView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = Provider.of<ConfirmationViewModel>(
      context,
      listen: false,
    );
    viewModel.initFromContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ConfirmationViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Header(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  viewModel.operation == ConfirmOperationsConstants.confirmEmail
                      ? 'Please enter the confirmation code sent to your email.'
                      : 'Please enter the confirmation code sent to your email to reset your password.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Confirmation Code'),
                  onChanged: (value) => viewModel.updateConfirmationCode(value),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      () async => await viewModel.handleConfirmClick(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
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
