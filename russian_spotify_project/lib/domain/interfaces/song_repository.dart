import 'package:russian_spotify_project/data/dto/song.dart';

abstract class SongRepository {
  Future<List<Song>> getFavoriteSongs();
}
