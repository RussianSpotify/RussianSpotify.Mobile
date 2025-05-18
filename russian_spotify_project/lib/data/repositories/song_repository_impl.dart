import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/core/utils/mock/songs_mock.dart';
import 'package:russian_spotify_project/data/services/graphql_service.dart';
import 'package:russian_spotify_project/domain/interfaces/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final GraphQlService _graphQlService;

  SongRepositoryImpl(this._graphQlService);

  @override
  Future<List<Song>> getFavoriteSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    return songsMock;
  }

  @override
  Future<List<Song>> searchSongs(String query) async {
    const String gqlQuery = r'''
      query SearchSongs($query: String!) {
        songs(filter: { name_contains: $query }) {
          id
          songName
          duration
          playsNumber
          category {
            id
            name
          }
          imageFileId
          songFileId
          authors {
            id
            userName
          }
        }
      }
    ''';

    final variables = {'query': query};

    try {
      final Map<String, dynamic> data = await _graphQlService.performQuery(
        query: gqlQuery,
        variables: variables,
      );

      final List<dynamic> songsJson = data['songs'];
      if (songsJson.isEmpty) {
        return [];
      }

      return songsJson.map((json) => Song.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search songs: $e');
    }
  }
}
