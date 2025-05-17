import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_favorite_songs_usecase.dart';
import 'user_profile_event.dart';
import 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetFavoriteSongsUseCase _getFavoriteSongsUseCase;

  UserProfileBloc(this._getFavoriteSongsUseCase) : super(UserProfileInitial()) {
    on<LoadFavoriteSongs>(_loadFavoriteSongs);
  }

  Future<void> _loadFavoriteSongs(
    LoadFavoriteSongs event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    try {
      final favoriteSongs = await _getFavoriteSongsUseCase.call();
      emit(UserProfileLoaded(favoriteSongs));
    } catch (e) {
      emit(UserProfileError("Failed to load favorite songs: $e"));
    }
  }
}
