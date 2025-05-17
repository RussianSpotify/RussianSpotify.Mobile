abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateUserInfo extends SettingsEvent {
  final String username;
  final String email;

  UpdateUserInfo(this.username, this.email);
}

class SelectPage extends SettingsEvent {
  final int pageId;

  SelectPage(this.pageId);
}
