import 'package:russian_spotify_project/data/services/graphql_service.dart';
import 'package:russian_spotify_project/domain/interfaces/playlist_repository.dart';
import '../dto/song.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final GraphQlService _graphQlService;

  PlaylistRepositoryImpl(this._graphQlService);

  @override
  Future<List<Song>> fetchSongs(int id) async {
    const String gqlQuery = r'''
      query GetPlaylistSongs($playlistId: ID!) {
        playlist(id: $playlistId) {
          id
          songs {
            id
            songName
            duration
            playsNumber
            category {
              id
              name
            }
            authors {
              id
              userName
            }
          }
        }
      }
    ''';

    try {
      // Выполняем GraphQL-запрос
      final Map<String, dynamic> data = await _graphQlService.performQuery(
        query: gqlQuery,
        variables: {'playlistId': id},
      );

      // Извлекаем список песен из ответа
      final List<dynamic> songsJson = data['playlist']['songs'];
      return songsJson.map((json) => Song.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch songs for playlist with ID $id: $e');
    }
  }
}
