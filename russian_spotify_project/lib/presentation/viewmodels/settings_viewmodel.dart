import 'package:flutter/cupertino.dart';

import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/get_settings_usecase.dart';

class SettingsViewModel extends ChangeNotifier {
  final GetSettingsUseCase _getSettingsUseCase;
  late List<SettingsEntity> _settingsPages;
  int _selectedPageId = 0;

  String _username = 'demo_user';
  String _email = 'demo@example.com';

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  SettingsViewModel(this._getSettingsUseCase) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      _settingsPages = await _getSettingsUseCase.call();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      _settingsPages = [];
      _isInitialized = true; // даже при ошибке можно считать завершённой
      notifyListeners();
    }
  }

  List<SettingsEntity> get settingsPages => _settingsPages;

  int get selectedPageId => _selectedPageId;

  SettingsEntity get selectedPage => _settingsPages.firstWhere(
    (e) => e.id == _selectedPageId,
    orElse: () => _settingsPages.first,
  );

  String get username => _username;
  String get email => _email;

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
