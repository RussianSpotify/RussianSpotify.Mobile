import 'package:flutter/cupertino.dart';
import 'package:russian_spotify_project/presentation/widgets/song/song_widget.dart';

import '../../../data/dto/song.dart';

class SongListWidget extends StatelessWidget {
  final List<Song> songs;

  const SongListWidget({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongWidget(song: song);
      },
    );
  }
}
