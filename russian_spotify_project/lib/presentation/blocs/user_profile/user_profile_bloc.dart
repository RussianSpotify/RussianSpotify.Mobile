import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_favorite_songs_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_user_info_usecase.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetFavoriteSongsUseCase _getFavoriteSongsUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  UserProfileBloc(this._getFavoriteSongsUseCase, this._getUserInfoUseCase)
    : super(UserProfileInitial()) {
    on<LoadFavoriteSongs>(_loadFavoriteSongs);
    on<LoadUserInfo>(_loadUserInfo);
  }

  Future<void> _loadFavoriteSongs(
    LoadFavoriteSongs event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    try {
      final favoriteSongs = await _getFavoriteSongsUseCase.call();
      emit(UserProfileLoaded(favoriteSongs: favoriteSongs));
    } catch (e) {
      emit(UserProfileError("Failed to load favorite songs: $e"));
    }
  }

  Future<void> _loadUserInfo(
    LoadUserInfo event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    try {
      final userInfo = await _getUserInfoUseCase.call();
      emit(UserProfileLoaded(userInfo: userInfo));
    } catch (e) {
      emit(UserProfileError("Failed to load user info: $e"));
    }
  }
}
