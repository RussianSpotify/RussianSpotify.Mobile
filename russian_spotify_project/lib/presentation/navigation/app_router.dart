// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import '../../core/utils/app_routes.dart';
import '../views/home_screen.dart';
import '../views/details_screen.dart';
import '../views/settings_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.details:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder:
              (_) => DetailsScreen(
                title: args?['title'] ?? 'No Title',
                description: args?['description'] ?? 'No Description',
              ),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
