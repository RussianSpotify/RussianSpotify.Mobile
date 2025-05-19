import 'package:russian_spotify_project/data/dto/album.dart';

abstract class AlbumsRepository {
  Future<List<Album>> getAlbums();
}
