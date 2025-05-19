import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/domain/interfaces/song_repository.dart';

abstract class SearchSongsUseCase {
  Future<List<Song>> call(String query);
}

class SearchSongsUseCaseImpl implements SearchSongsUseCase {
  final SongRepository _songsRepository;

  SearchSongsUseCaseImpl(this._songsRepository);

  @override
  Future<List<Song>> call(String query) async {
    return await _songsRepository.searchSongs(query);
  }
}
