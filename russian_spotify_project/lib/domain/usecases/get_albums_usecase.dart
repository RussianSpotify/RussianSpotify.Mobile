import 'package:russian_spotify_project/data/dto/album.dart';
import 'package:russian_spotify_project/domain/interfaces/album_repository.dart';

abstract class GetAlbumsUseCase {
  Future<List<Album>> call();
}

class GetAlbumsUseCaseImpl implements GetAlbumsUseCase {
  final AlbumsRepository _albumsRepository;

  GetAlbumsUseCaseImpl(this._albumsRepository);

  @override
  Future<List<Album>> call() async {
    return await _albumsRepository.getAlbums();
  }
}
