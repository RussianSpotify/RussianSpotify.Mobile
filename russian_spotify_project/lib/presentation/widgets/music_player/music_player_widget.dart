import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_state.dart';
import 'music_player_bloc.dart';
import 'music_player_event.dart';
import 'music_player_state.dart';

class MusicPlayerWidget extends StatelessWidget {
  const MusicPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        // Проверяем, залогинен ли пользователь
        final isAuthenticated = authState is Authenticated;

        return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, playerState) {
            // Проверяем, играет ли музыка
            final isPlaying = playerState is AudioPlayerPlaying;

            // Если пользователь не залогинен или музыка не играет, скрываем виджет
            if (!isAuthenticated || !isPlaying) {
              return const SizedBox.shrink(); // Возвращаем пустой виджет
            }

            return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 4, // Добавляем тень для визуального разделения
                child: Container(
                  color: Colors.black.withAlpha(230), // Темный фон
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSongInfo(context),
                        _buildControlsRow(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Построение информации о текущей песне
  Widget _buildSongInfo(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is AudioPlayerPlaying || state is AudioPlayerPaused) {
          final currentSong = state is AudioPlayerPlaying
              ? state.currentSong
              : (state as AudioPlayerPaused).currentSong;
          final authors = state is AudioPlayerPlaying
              ? state.authors
              : (state as AudioPlayerPaused).authors;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentSong,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis, // Обрезаем текст, если он длинный
                maxLines: 1,
              ),
              Text(
                authors.join(', '),
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                overflow: TextOverflow.ellipsis, // Обрезаем текст, если он длинный
                maxLines: 1,
              ),
            ],
          );
        } else {
          return const Text(
            'No song playing',
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        }
      },
    );
  }

  /// Построение строки управления плеером
  Widget _buildControlsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Равномерное распределение кнопок
      children: [
        _buildIconButton(Icons.repeat, 'Repeat', () {}, iconSize: 25),
        _buildIconButton(Icons.skip_previous, 'Previous', () {
          context.read<AudioPlayerBloc>().add(PreviousSongEvent());
        }, iconSize: 30),
        _buildMainActionButton(context),
        _buildIconButton(Icons.skip_next, 'Next', () {
          context.read<AudioPlayerBloc>().add(NextSongEvent());
        }, iconSize: 30),
        _buildIconButton(Icons.favorite_border, 'Like', () {}, iconSize: 25),
      ],
    );
  }

  /// Главная кнопка воспроизведения/паузы
  Widget _buildMainActionButton(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        final isPlaying = state is AudioPlayerPlaying;
        return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: Colors.purple,
            size: 40, // Большая кнопка для основного действия
          ),
          onPressed: () {
            context.read<AudioPlayerBloc>().add(PlayPauseEvent());
          },
        );
      },
    );
  }

  /// Универсальный метод для создания кнопок
  Widget _buildIconButton(
      IconData icon,
      String tooltip,
      VoidCallback onPressed, {
        double iconSize = 20,
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.purple, size: iconSize),
        ],
      ),
    );
  }
}