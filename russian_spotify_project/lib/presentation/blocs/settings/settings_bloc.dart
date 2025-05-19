import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/entities/settings_entity.dart';
import 'package:russian_spotify_project/domain/usecases/get_settings_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase _getSettingsUseCase;
  late List<SettingsEntity> _settingsPages;
  int _selectedPageId = 0;
  String _username = 'demo_user';
  String _email = 'demo@example.com';

  SettingsBloc(this._getSettingsUseCase) : super(SettingsInitial()) {
    on<LoadSettings>(_loadSettings);
    on<UpdateUserInfo>(_updateUserInfo);
    on<SelectPage>(_selectPage);
  }

  Future<void> _loadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    try {
      _settingsPages = await _getSettingsUseCase.call();
      emit(
        SettingsLoaded(
          settingsPages: _settingsPages,
          selectedPageId: _selectedPageId,
          username: _username,
          email: _email,
        ),
      );
    } catch (e) {
      emit(SettingsError("Failed to load settings: $e"));
    }
  }

  void _updateUserInfo(UpdateUserInfo event, Emitter<SettingsState> emit) {
    _username = event.username;
    _email = event.email;

    emit(
      SettingsLoaded(
        settingsPages: _settingsPages,
        selectedPageId: _selectedPageId,
        username: _username,
        email: _email,
      ),
    );
  }

  void _selectPage(SelectPage event, Emitter<SettingsState> emit) {
    _selectedPageId = event.pageId;

    emit(
      SettingsLoaded(
        settingsPages: _settingsPages,
        selectedPageId: _selectedPageId,
        username: _username,
        email: _email,
      ),
    );
  }
}
