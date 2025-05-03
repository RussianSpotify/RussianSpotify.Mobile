import 'package:get_it/get_it.dart';

import '../../domain/usecases/get_settings_usecase.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<GetSettingsUseCase>(
    () => GetSettingsUseCaseImpl(),
  );
  locator.registerFactory<SettingsViewModel>(
    () => SettingsViewModel(locator<GetSettingsUseCase>()),
  );
}
