import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/app_routes.dart';
import 'package:russian_spotify_project/presentation/widgets/auth/register_widget.dart';
import '../widgets/auth/header_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            SizedBox(height: 100),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RegisterWidget(),
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
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: const Text(
                          "Log in to Spotify",
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
