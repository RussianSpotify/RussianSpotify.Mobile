import 'package:russian_spotify_project/data/dto/album.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Album> albums;

  HomeLoaded(this.albums);
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}
