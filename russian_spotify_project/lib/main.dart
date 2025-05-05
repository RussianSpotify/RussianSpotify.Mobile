import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/navigation/app_router.dart';
import 'package:russian_spotify_project/presentation/viewmodels/about_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/confirmation_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/login_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/payment_history_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/register_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/reset_password_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/settings_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/subscription_viewmodel.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsViewModel>(
          create: (_) => locator<SettingsViewModel>(),
        ),
        ChangeNotifierProvider<SubscriptionViewModel>(
          create: (_) => locator<SubscriptionViewModel>(),
        ),
        ChangeNotifierProvider<AboutViewModel>(
          create: (_) => locator<AboutViewModel>(),
        ),
        ChangeNotifierProvider<PaymentHistoryViewModel>(
          create: (_) => locator<PaymentHistoryViewModel>(),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => locator<LoginViewModel>(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (_) => locator<RegisterViewModel>(),
        ),
        ChangeNotifierProvider<ConfirmationViewModel>(
          create: (_) => locator<ConfirmationViewModel>(),
        ),
        ChangeNotifierProvider<ResetPasswordViewModel>(
          create: (_) => locator<ResetPasswordViewModel>(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp(
        title: 'Spotify',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
      )
    );
  }
}
