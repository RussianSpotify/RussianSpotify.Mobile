import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/app_routes.dart';

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
              padding: EdgeInsets.only(top: 20, bottom: 0),
              child: const Header(),
            ),
            SizedBox(height: 100),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AuthForm(),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          top: 3,
                          right: 3,
                          bottom: 3,
                        ),
                        child: const Text(
                          "Sign up for Spotify",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
