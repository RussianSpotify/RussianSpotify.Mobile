import 'package:russian_spotify_project/data/dto/song.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Song> songs;

  SearchLoaded(this.songs);
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}
