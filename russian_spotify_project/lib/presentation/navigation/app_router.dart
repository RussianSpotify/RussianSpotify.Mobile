import 'package:flutter/material.dart';
import 'package:russian_spotify_project/presentation/views/about_view.dart';
import 'package:russian_spotify_project/presentation/views/confirmation_view.dart';
import 'package:russian_spotify_project/presentation/views/payment_history_view.dart';
import 'package:russian_spotify_project/presentation/views/playlist_view.dart';
import 'package:russian_spotify_project/presentation/views/register_view.dart';
import 'package:russian_spotify_project/presentation/views/reset_password_view.dart';
import 'package:russian_spotify_project/presentation/views/search_view.dart';
import 'package:russian_spotify_project/presentation/views/subscription_view.dart';
import '../../core/utils/app_routes.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/settings_view.dart';
import '../views/user_profile_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case AppRoutes.subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionView());
      case AppRoutes.paymentHistory:
        return MaterialPageRoute(builder: (_) => const PaymentHistoryView());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.confirmation:
        return MaterialPageRoute(builder: (_) => const ConfirmationView());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case AppRoutes.myLibrary:
        return MaterialPageRoute(builder: (_) => const PlaylistView());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const UserProfileView());
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
