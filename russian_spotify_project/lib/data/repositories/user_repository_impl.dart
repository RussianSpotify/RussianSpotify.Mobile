import 'package:russian_spotify_project/data/services/graphql_service.dart';
import 'package:russian_spotify_project/domain/entities/user_entity.dart';

import 'package:russian_spotify_project/domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final GraphQlService _graphQlService;

  UserRepositoryImpl(this._graphQlService);

  @override
  Future<User> getUserInfo() async {
    const String gqlQuery = r'''
    query GetUser {
      user {
        id
        userName
        email
        phone
        birthday
      }
    }
  ''';

    try {
      // Выполняем GraphQL-запрос
      final Map<String, dynamic> data = await _graphQlService.performQuery(
        query: gqlQuery,
      );

      // Извлекаем данные пользователя из ответа
      final Map<String, dynamic> userJson = data['user'];
      return User.fromJson(userJson);
    } catch (e) {
      throw Exception('Failed to load user info: $e');
    }
  }
}
