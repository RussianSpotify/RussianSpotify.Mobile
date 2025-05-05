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
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                playerService.currentSong != null
                    ? playerService.currentSong!.title
                    : 'No song playing',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                playerService.currentSong != null
                    ? playerService.currentSong!.artist
                    : '',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Повтор
                  IconButton(
                    icon: const Icon(Icons.repeat, color: Colors.purple),
                    iconSize: 20,
                    onPressed: () {
                      // Логика для повтора
                    },
                  ),
                  const SizedBox(width: 10),
                  // Перемешивание
                  IconButton(
                    icon: const Icon(Icons.shuffle, color: Colors.purple),
                    iconSize: 20,
                    onPressed: () {
                      // Логика для перемешивания
                    },
                  ),
                  const SizedBox(width: 10),
                  // Предыдущая песня
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.purple),
                    iconSize: 35,
                    onPressed: () async {
                      await playerService.previousSong();
                    },
                  ),
                  // Пауза/Воспроизведение
                  IconButton(
                    icon: Icon(
                      playerService.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.purple,
                    ),
                    iconSize: 35,
                    onPressed: () async {
                      await playerService.togglePlayPause();
                    },
                  ),
                  // Следующая песня
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.purple),
                    iconSize: 35,
                    onPressed: () async {
                      await playerService.nextSong();
                    },
                  ),
                  const SizedBox(width: 10),
                  // Лайк
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.purple,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      // Логика для лайка песни
                    },
                  ),
                  const SizedBox(width: 10),
                  // Плейлист
                  IconButton(
                    icon: const Icon(Icons.queue_music, color: Colors.purple),
                    iconSize: 20,
                    onPressed: () {
                      // Логика для просмотра текущего плейлиста
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
