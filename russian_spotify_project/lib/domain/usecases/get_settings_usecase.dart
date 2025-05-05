import '../../domain/entities/settings_entity.dart';
import '../../domain/interfaces/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<List<SettingsEntity>> call() async {
    return await repository.getSettings();
  }
}
