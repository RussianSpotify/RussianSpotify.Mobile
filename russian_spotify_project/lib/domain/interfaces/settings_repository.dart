import '../../domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<List<SettingsEntity>> getSettings();
}
