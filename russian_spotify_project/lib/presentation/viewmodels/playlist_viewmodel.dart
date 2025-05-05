import 'package:flutter/material.dart';
import '../../data/dto/song.dart';
import '../../domain/usecases/get_playlist_usecase.dart';

class PlaylistViewModel extends ChangeNotifier {
  final GetPlaylistUseCase _getPlaylistUseCase;

  PlaylistViewModel(this._getPlaylistUseCase);

  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Future<void> loadSongs(int id) async {
    _songs = await _getPlaylistUseCase.call(id);
    notifyListeners();
  }
}
