import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
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
        BlocProvider<AuthBloc>(create: (_) => locator<AuthBloc>()),
        BlocProvider<AudioPlayerBloc>(
          create: (_) => locator<AudioPlayerBloc>(),
        ),
      ],
      child: MyApp(),
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
        initialRoute: AppRoutes.chat,
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
