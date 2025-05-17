import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_playlist_usecase.dart';
import 'playlist_event.dart';
import 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final GetPlaylistUseCase _getPlaylistUseCase;

  PlaylistBloc(this._getPlaylistUseCase) : super(PlaylistInitial()) {
    on<LoadPlaylist>(_loadPlaylist);
  }

  Future<void> _loadPlaylist(
    LoadPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistLoading());

    try {
      final songs = await _getPlaylistUseCase.call(event.playlistId);
      emit(PlaylistLoaded(songs));
    } catch (e) {
      emit(PlaylistError('Failed to load playlist: $e'));
    }
  }
}
