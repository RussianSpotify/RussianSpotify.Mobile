import 'package:russian_spotify_project/core/utils/mock/albums_mock.dart';
import 'package:russian_spotify_project/data/dto/album.dart';
import 'package:russian_spotify_project/domain/interfaces/album_repository.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  @override
  Future<List<Album>> getAlbums() async {
    // Имитация задержки для загрузки данных
    await Future.delayed(const Duration(seconds: 1));
    return albumsMock; // Возвращаем mock-данные
  }
}
