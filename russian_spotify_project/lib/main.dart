import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_event.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/home/home_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:russian_spotify_project/presentation/navigation/app_router.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player/music_player_bloc.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player/music_player_widget.dart';

import 'core/di/locator.dart';
import 'core/utils/app_routes.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<AboutBloc>(
          create: (_) => locator<AboutBloc>()..add(LoadAboutData()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => locator<AuthBloc>(),
        ),
        BlocProvider<SettingsBloc>(create: (_) => locator<SettingsBloc>()),
        BlocProvider<SubscriptionBloc>(
          create: (_) => locator<SubscriptionBloc>(),
        ),
        BlocProvider<PaymentHistoryBloc>(
          create: (_) => locator<PaymentHistoryBloc>(),
        ),
        BlocProvider<PlaylistBloc>(create: (_) => locator<PlaylistBloc>()),
        BlocProvider<UserProfileBloc>(
          create: (_) => locator<UserProfileBloc>(),
        ),
        BlocProvider<HomeBloc>(create: (_) => locator<HomeBloc>()),
        BlocProvider<AudioPlayerBloc>(create: (_) => locator<AudioPlayerBloc>()),
        BlocProvider<SearchBloc>(create: (_) => locator<SearchBloc>()),
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
        initialRoute: AppRoutes.register,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return Scaffold(
            body: Stack(
              children: [
                child!, // Основной контент приложения
                const MusicPlayerWidget(), // Добавляем плеер на экран
              ],
            ),
          );
        },
      ),
    );
  }
}
