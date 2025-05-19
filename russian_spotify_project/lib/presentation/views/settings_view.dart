import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_event.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsInitial) {
          context.read<SettingsBloc>().add(LoadSettings());
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingsLoaded) {
          final selectedPage = state.settingsPages.firstWhere(
            (e) => e.id == state.selectedPageId,
            orElse: () => state.settingsPages.first,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: selectedPage.component)],
          );
        } else if (state is SettingsError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown state', style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }
}
