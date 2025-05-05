import 'package:flutter/foundation.dart';

import '../../data/dto/song.dart';
import '../utils/mock/playlists_mock.dart';

class AudioPlayerService with ChangeNotifier {
  List<Song> _playlist = [];
  int _currentIndex = 0;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Song? get currentSong =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;

  AudioPlayerService() {
    _playlist = playlistsMock.firstWhere((p) => p.id == 1).songs;
  }

  Future<void> togglePlayPause() async {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  Future<void> nextSong() async {
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    // Просто обновляем индекс песни, без реального перехода к файлу
    if (_isPlaying) {
      notifyListeners();
    }
  }

  Future<void> previousSong() async {
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    if (_isPlaying) {
      notifyListeners();
    }
  }

  void setPlaylist(List<Song> playlist) {
    _playlist = playlist;
    _currentIndex = 0;
    notifyListeners();
  }
}
