import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/domain/entities/user_entity.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final List<Song>? favoriteSongs;
  final User? userInfo;

  UserProfileLoaded({this.favoriteSongs, this.userInfo});
}

class UserProfileError extends UserProfileState {
  final String errorMessage;

  UserProfileError(this.errorMessage);
}
