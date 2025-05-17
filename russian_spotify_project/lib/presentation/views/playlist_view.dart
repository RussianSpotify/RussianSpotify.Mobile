import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/playlist/playlist_event.dart';
import 'package:russian_spotify_project/presentation/blocs/playlist/playlist_state.dart';
import '../widgets/song/song_list_widget.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlist'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black,
      body: BlocConsumer<PlaylistBloc, PlaylistState>(
        listener: (context, state) {
          // Дополнительные действия при изменении состояния (если нужны)
        },
        builder: (context, state) {
          if (state is PlaylistInitial) {
            // Загружаем данные при первом запуске
            context.read<PlaylistBloc>().add(LoadPlaylist(1));
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          } else if (state is PlaylistLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          } else if (state is PlaylistLoaded) {
            return SongListWidget(songs: state.songs);
          } else if (state is PlaylistError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Unknown state',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
