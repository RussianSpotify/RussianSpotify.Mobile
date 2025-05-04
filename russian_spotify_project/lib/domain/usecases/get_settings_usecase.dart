import '../../presentation/widgets/personal_settings_widget.dart';
import '../entities/settings_entity.dart';

abstract class GetSettingsUseCase {
  List<SettingsEntity> call();
}

class GetSettingsUseCaseImpl implements GetSettingsUseCase {
  @override
  List<SettingsEntity> call() {
    return [
      SettingsEntity(
        id: 0,
        name: 'Personal',
        component: const PersonalSettingsWidget(),
      ),
    ];
  }
}
