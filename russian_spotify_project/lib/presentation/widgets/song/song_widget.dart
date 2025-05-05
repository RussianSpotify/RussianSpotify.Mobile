import 'package:flutter/material.dart';

import '../../../data/dto/song.dart';

class SongWidget extends StatelessWidget {
  final Song song; // Принимаем песню через конструктор

  const SongWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title, style: TextStyle(color: Colors.white)),
      subtitle: Text(song.artist, style: TextStyle(color: Colors.grey)),
      leading: Icon(Icons.music_note, color: Colors.purple),
      trailing: Icon(Icons.play_arrow, color: Colors.white),
    );
  }
}
