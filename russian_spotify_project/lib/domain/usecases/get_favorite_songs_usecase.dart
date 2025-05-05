import 'package:russian_spotify_project/data/dto/song.dart';

import '../interfaces/song_repository.dart';

class GetFavoriteSongsUseCase {
  final SongRepository songRepository;

  GetFavoriteSongsUseCase(this.songRepository);

  Future<List<Song>> call() async {
    return await songRepository.getFavoriteSongs();
  }
}
