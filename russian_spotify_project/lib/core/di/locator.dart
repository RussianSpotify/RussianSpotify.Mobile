// lib/core/di/locator.dart

import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory<ExampleRepository>(() => ExampleRepoImpl());
}
