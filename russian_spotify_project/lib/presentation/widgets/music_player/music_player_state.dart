abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  final String currentSong;
  final List<String> authors;

  AudioPlayerPlaying({required this.currentSong, required this.authors});
}

class AudioPlayerPaused extends AudioPlayerState {
  final String currentSong;
  final List<String> authors;

  AudioPlayerPaused({required this.currentSong, required this.authors});
}