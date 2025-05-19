

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player/music_player_event.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player/music_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    on<PlayPauseEvent>((event, emit) {
      // Логика переключения воспроизведения/паузы
      if (state is AudioPlayerPlaying) {
        emit(AudioPlayerPaused(
          currentSong: (state as AudioPlayerPlaying).currentSong,
          authors: (state as AudioPlayerPlaying).authors,
        ));
      } else {
        emit(AudioPlayerPlaying(
          currentSong: 'Sample Song',
          authors: ['Author 1', 'Author 2'],
        ));
      }
    });

    on<NextSongEvent>((event, emit) {
      // Логика перехода к следующей песне
      emit(AudioPlayerPlaying(
        currentSong: 'Next Song',
        authors: ['Author A', 'Author B'],
      ));
    });

    on<PreviousSongEvent>((event, emit) {
      // Логика перехода к предыдущей песне
      emit(AudioPlayerPlaying(
        currentSong: 'Previous Song',
        authors: ['Author X', 'Author Y'],
      ));
    });
  }
}