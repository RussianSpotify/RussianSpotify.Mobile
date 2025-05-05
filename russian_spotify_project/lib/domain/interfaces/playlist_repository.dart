import '../../data/dto/song.dart';

abstract class PlaylistRepository {
  Future<List<Song>> fetchSongs(int id);
}
