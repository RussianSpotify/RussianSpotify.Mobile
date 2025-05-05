import 'package:flutter/material.dart';
import '../widgets/auth/header_widget.dart';
import '../widgets/auth/reset_password_widget.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
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
          children: const [
            Header(),
            Padding(padding: EdgeInsets.all(24.0), child: ResetPasswordForm()),
          ],
        ),
      ),
    );
  }
}
