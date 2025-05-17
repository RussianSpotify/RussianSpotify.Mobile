import 'package:russian_spotify_project/data/dto/song.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final List<Song> favoriteSongs;

  UserProfileLoaded(this.favoriteSongs);
}

class UserProfileError extends UserProfileState {
  final String errorMessage;

  UserProfileError(this.errorMessage);
}
