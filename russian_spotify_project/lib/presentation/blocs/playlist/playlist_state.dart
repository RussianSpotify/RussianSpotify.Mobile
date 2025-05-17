import 'package:russian_spotify_project/data/dto/song.dart';

abstract class PlaylistState {}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<Song> songs;

  PlaylistLoaded(this.songs);
}

class PlaylistError extends PlaylistState {
  final String errorMessage;

  PlaylistError(this.errorMessage);
}
