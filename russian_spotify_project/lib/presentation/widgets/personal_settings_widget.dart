import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_event.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_state.dart';
import '../views/layout/main_scaffold.dart';

class PersonalSettingsWidget extends StatelessWidget {
  const PersonalSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return MainScaffold(
            appBar: AppBar(
              title: const Text('Personal Settings'),
              backgroundColor: Colors.purple,
            ),
            body: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfoTile(
                    text: 'Your username',
                    value: state.username,
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  UserInfoTile(
                    text: 'Your email',
                    value: state.email,
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showEditDialog(context, state),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Edit your info"),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _showEditDialog(BuildContext context, SettingsLoaded state) {
    final usernameController = TextEditingController(text: state.username);
    final emailController = TextEditingController(text: state.email);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              "Edit Info",
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF300B44),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  context.read<SettingsBloc>().add(
                    UpdateUserInfo(
                      usernameController.text,
                      emailController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final String text;
  final String value;
  final TextStyle? textStyle;

  const UserInfoTile({
    super.key,
    required this.text,
    required this.value,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                textStyle?.copyWith(fontWeight: FontWeight.bold) ??
                DefaultTextStyle.of(context).style,
          ),
          Text(
            value,
            style:
                textStyle?.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                ) ??
                DefaultTextStyle.of(context).style,
          ),
        ],
      ),
    );
  }
}
