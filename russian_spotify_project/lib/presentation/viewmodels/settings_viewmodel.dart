import 'package:flutter/material.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/get_settings_usecase.dart';

class SettingsViewModel extends ChangeNotifier {
  final GetSettingsUseCase _getSettingsUseCase;

  SettingsViewModel(this._getSettingsUseCase) {
    _settingsPages = _getSettingsUseCase.call();
  }

  late List<SettingsEntity> _settingsPages;
  int _selectedPageId = 0;

  // 💡 Простая модель данных пользователя
  String _username = 'demo_user';
  String _email = 'demo@example.com';

  List<SettingsEntity> get settingsPages => _settingsPages;

  int get selectedPageId => _selectedPageId;

  SettingsEntity get selectedPage =>
      _settingsPages.firstWhere((e) => e.id == _selectedPageId);

  // ✅ Добавляем нужные геттеры
  String get username => _username;
  String get email => _email;

  // ✅ Метод обновления данных пользователя
  void updateUserInfo(String newUsername, String newEmail) {
    _username = newUsername;
    _email = newEmail;
    notifyListeners();
  }

  void selectPage(int id) {
    _selectedPageId = id;
    notifyListeners();
  }
}
