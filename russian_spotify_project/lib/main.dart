import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/navigation/app_router.dart';
import 'package:russian_spotify_project/presentation/viewmodels/about_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/payment_history_viewmodel.dart';
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
      ],
      child: MaterialApp(
        title: 'Spotify',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.paymentHistory,
      ),
    );
  }
}
