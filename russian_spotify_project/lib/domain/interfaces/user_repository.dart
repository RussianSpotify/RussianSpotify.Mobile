import 'package:russian_spotify_project/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<User> getUserInfo();
}
