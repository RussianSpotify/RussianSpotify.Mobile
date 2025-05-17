import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/core/utils/mock/songs_mock.dart';
import 'package:russian_spotify_project/domain/interfaces/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  @override
  Future<List<Song>> getFavoriteSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    return songsMock;
  }

  @override
  Future<List<Song>> searchSongs(String query) async {
    // Имитация задержки для загрузки данных
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return []; // Возвращаем пустой список, если запрос пустой
    }

    final lowerQuery = query.toLowerCase();
    return songsMock.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
          song.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
