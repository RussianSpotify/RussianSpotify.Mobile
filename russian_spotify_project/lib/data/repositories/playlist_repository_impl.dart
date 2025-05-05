import 'package:russian_spotify_project/core/utils/mock/playlists_mock.dart';
import 'package:russian_spotify_project/domain/interfaces/playlist_repository.dart';

import '../dto/song.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  @override
  Future<List<Song>> fetchSongs(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return playlistsMock.firstWhere((p) => p.id == id).songs;
  }
}
