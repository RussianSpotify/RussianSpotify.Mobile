import 'package:flutter/material.dart';
import 'package:russian_spotify_project/data/dto/song.dart';

import '../../domain/usecases/get_favorite_songs_usecase.dart';

class UserProfileViewModel extends ChangeNotifier {
  final GetFavoriteSongsUseCase _getFavoriteSongsUseCase;

  UserProfileViewModel(this._getFavoriteSongsUseCase);

  List<Song> _favoriteSongs = [];
  List<Song> get favoriteSongs => _favoriteSongs;

  String username = 'Irek';
  String email = 'irek@example.com';

  Future<void> loadFavoriteSongs() async {
    _favoriteSongs = await _getFavoriteSongsUseCase.call();
    notifyListeners();
  }
}
