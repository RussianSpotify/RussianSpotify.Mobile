import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/audio_player_service.dart';

class MusicPlayerWidget extends StatelessWidget {
  const MusicPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final playerService = Provider.of<AudioPlayerService>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        child: Container(
          color: Colors.black.withValues(alpha: 0.9),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSongInfo(playerService),
              const SizedBox(height: 10),
              _buildControlsRow(playerService),
            ],
          ),
        ),
      ),
    );
  }

  /// Построение информации о текущей песне
  Widget _buildSongInfo(AudioPlayerService playerService) {
    return Column(
      children: [
        Text(
          playerService.currentSong != null
              ? playerService
                  .currentSong!
                  .songName // Используем songName
              : 'No song playing',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        if (playerService.currentSong != null)
          Text(
            playerService.currentSong!.authors
                .map((author) => author.userName) // Объединяем имена авторов
                .join(', '),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
      ],
    );
  }

  /// Построение строки управления плеером
  Widget _buildControlsRow(AudioPlayerService playerService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(Icons.repeat, 'Repeat', () {
          // Логика для повтора
        }),
        const SizedBox(width: 10),
        _buildIconButton(Icons.shuffle, 'Shuffle', () {
          // Логика для перемешивания
        }),
        const SizedBox(width: 10),
        _buildIconButton(Icons.skip_previous, 'Previous', () async {
          await playerService.previousSong();
        }, iconSize: 35),
        const SizedBox(width: 10),
        _buildIconButton(
          playerService.isPlaying ? Icons.pause : Icons.play_arrow,
          playerService.isPlaying ? 'Pause' : 'Play',
          () async {
            await playerService.togglePlayPause();
          },
          iconSize: 35,
        ),
        const SizedBox(width: 10),
        _buildIconButton(Icons.skip_next, 'Next', () async {
          await playerService.nextSong();
        }, iconSize: 35),
        const SizedBox(width: 10),
        _buildIconButton(Icons.favorite_border, 'Like', () {
          // Логика для лайка песни
        }),
        const SizedBox(width: 10),
        _buildIconButton(Icons.queue_music, 'Playlist', () {
          // Логика для просмотра текущего плейлиста
        }),
      ],
    );
  }

  /// Универсальный метод для создания кнопок
  Widget _buildIconButton(
    IconData icon,
    String tooltip,
    VoidCallback onPressed, {
    double iconSize = 20,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.purple, size: iconSize),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
