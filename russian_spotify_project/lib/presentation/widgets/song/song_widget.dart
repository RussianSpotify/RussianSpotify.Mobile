import 'package:flutter/material.dart';
import '../../../data/dto/song.dart';

class SongWidget extends StatelessWidget {
  final Song song; // Принимаем песню через конструктор
  final VoidCallback? onTap; // Добавляем callback для обработки нажатий

  const SongWidget({
    super.key,
    required this.song,
    this.onTap, // Необязательный параметр для обработки нажатий
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Обработка нажатия на весь элемент
      child: ListTile(
        title: Text(
          song.songName, // Используем songName вместо title
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          song.authors
              .map((author) => author.userName)
              .join(', '), // Объединяем имена авторов
          style: const TextStyle(color: Colors.grey),
        ),
        leading: const Icon(Icons.music_note, color: Colors.purple),
        trailing: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }
}
