import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/navigation/app_router.dart';
import 'package:russian_spotify_project/presentation/viewmodels/about_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/confirmation_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/login_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/payment_history_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/playlist_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/register_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/reset_password_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/settings_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/subscription_viewmodel.dart';
import 'package:russian_spotify_project/presentation/viewmodels/user_profile_viewmodel.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player_widget.dart';

import 'core/di/locator.dart';
import 'core/services/audio_player_service.dart';
import 'core/utils/app_routes.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioPlayerService>(
          create: (_) => AudioPlayerService(),
        ),
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
        ChangeNotifierProvider<PlaylistViewModel>(
          create: (_) => locator<PlaylistViewModel>(),
        ),
        ChangeNotifierProvider<UserProfileViewModel>(
          create: (_) => locator<UserProfileViewModel>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
        initialRoute: AppRoutes.profile,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              const MusicPlayerWidget(), // Добавляем плеер на экран
            ],
          );
        },
      ),
    );
  }
}
