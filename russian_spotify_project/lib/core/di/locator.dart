import 'package:get_it/get_it.dart';
import 'package:russian_spotify_project/data/repositories/settings_repository_impl.dart';
import 'package:russian_spotify_project/domain/interfaces/settings_repository.dart';
import 'package:russian_spotify_project/domain/usecases/get_subscription_options_usecase.dart';

import '../../data/repositories/payment_history_repository_impl.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/interfaces/payment_history_repository.dart';
import '../../domain/interfaces/subcription_repository.dart';
import '../../domain/usecases/get_payment_history_usecase.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/make_subscription_usecase.dart';
import '../../presentation/viewmodels/payment_history_viewmodel.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';
import '../../presentation/viewmodels/subscription_viewmodel.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  // Settings
  locator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(),
  );
  locator.registerLazySingleton<GetSettingsUseCase>(
    () => GetSettingsUseCase(locator<SettingsRepository>()),
  );
  locator.registerFactory<SettingsViewModel>(
    () => SettingsViewModel(locator<GetSettingsUseCase>()),
  );

  // Subscription
  locator.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(),
  );
  locator.registerLazySingleton<MakeSubscriptionUseCase>(
    () => MakeSubscriptionUseCase(locator<SubscriptionRepository>()),
  );
  locator.registerLazySingleton<GetSubscriptionOptionsUseCase>(
    () => GetSubscriptionOptionsUseCase(locator<SubscriptionRepository>()),
  );
  locator.registerFactory<SubscriptionViewModel>(
    () => SubscriptionViewModel(
      locator<GetSubscriptionOptionsUseCase>(),
      locator<MakeSubscriptionUseCase>(),
    ),
  );

  // Payment history
  locator.registerLazySingleton<PaymentHistoryRepository>(
    () => PaymentHistoryRepositoryImpl(),
  );
  locator.registerLazySingleton<GetPaymentHistoryUseCase>(
    () => GetPaymentHistoryUseCase(locator<PaymentHistoryRepository>()),
  );
  locator.registerFactory<PaymentHistoryViewModel>(
    () => PaymentHistoryViewModel(locator<GetPaymentHistoryUseCase>()),
  );
}
