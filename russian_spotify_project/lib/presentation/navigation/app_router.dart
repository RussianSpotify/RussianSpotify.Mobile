import 'package:flutter/material.dart';
import 'package:russian_spotify_project/presentation/views/about_view.dart';
import 'package:russian_spotify_project/presentation/views/payment_history_view.dart';
import 'package:russian_spotify_project/presentation/views/subscription_view.dart';
import '../../core/utils/app_routes.dart';
import '../views/settings_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case AppRoutes.subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionView());
      case AppRoutes.paymentHistory:
        return MaterialPageRoute(builder: (_) => const PaymentHistoryView());
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
