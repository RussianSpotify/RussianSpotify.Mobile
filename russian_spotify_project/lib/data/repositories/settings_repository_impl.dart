import '../../domain/entities/settings_entity.dart';
import '../../domain/interfaces/settings_repository.dart';
import '../../presentation/widgets/personal_settings_widget.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<List<SettingsEntity>> getSettings() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      SettingsEntity(
        id: 0,
        name: 'Personal',
        component: const PersonalSettingsWidget(),
      ),
    ];
  }
}
