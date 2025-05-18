import 'package:http/http.dart' as http;
import 'package:russian_spotify_project/domain/entities/user_entity.dart';
import 'dart:convert';

import 'package:russian_spotify_project/domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final String baseUrl;

  UserRepositoryImpl({required this.baseUrl});

  @override
  Future<User> getUserInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/api/user'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(
        jsonData,
      ); // Предполагаем, что у нас есть метод fromJson
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
