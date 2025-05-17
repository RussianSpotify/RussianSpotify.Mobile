import 'package:russian_spotify_project/domain/entities/settings_entity.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final List<SettingsEntity> settingsPages;
  final int selectedPageId;
  final String username;
  final String email;

  SettingsLoaded({
    required this.settingsPages,
    required this.selectedPageId,
    required this.username,
    required this.email,
  });
}

class SettingsError extends SettingsState {
  final String errorMessage;

  SettingsError(this.errorMessage);
}
