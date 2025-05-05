import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/core/utils/mock/songs_mock.dart';
import 'package:russian_spotify_project/domain/interfaces/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  @override
  Future<List<Song>> getFavoriteSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    return songsMock;
  }
}
