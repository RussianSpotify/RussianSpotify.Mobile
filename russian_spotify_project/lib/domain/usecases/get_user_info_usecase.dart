import 'package:russian_spotify_project/domain/entities/user_entity.dart';
import 'package:russian_spotify_project/domain/interfaces/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository repository;

  GetUserInfoUseCase(this.repository);

  Future<User> call() async {
    return await repository.getUserInfo();
  }
}
