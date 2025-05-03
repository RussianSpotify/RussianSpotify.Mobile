import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/navigation/app_router.dart';
import 'package:russian_spotify_project/presentation/viewmodels/settings_viewmodel.dart';

import 'core/di/locator.dart';
import 'core/utils/app_routes.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (_) => locator<SettingsViewModel>(),
      child: MaterialApp(
        title: 'Settings App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.settings,
      ),
    );
  }
}
