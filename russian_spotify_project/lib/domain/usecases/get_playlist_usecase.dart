import '../../data/dto/song.dart';
import '../interfaces/playlist_repository.dart';

class GetPlaylistUseCase {
  final PlaylistRepository repository;

  GetPlaylistUseCase(this.repository);

  Future<List<Song>> call(int id) async {
    return await repository.fetchSongs(id);
  }
}
