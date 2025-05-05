import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/widgets/song/song_list_widget.dart';
import '../viewmodels/playlist_viewmodel.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlaylistViewModel>(context);
    if (viewModel.songs.isEmpty) {
      viewModel.loadSongs(1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Playlist'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black,
      body: SongListWidget(songs: viewModel.songs),
    );
  }
}
