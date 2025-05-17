import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_albums_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAlbumsUseCase _getAlbumsUseCase;

  HomeBloc(this._getAlbumsUseCase) : super(HomeInitial()) {
    on<LoadAlbums>(_loadAlbums);
  }

  Future<void> _loadAlbums(LoadAlbums event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      // Получаем альбомы через UseCase
      final albums = await _getAlbumsUseCase.call();
      emit(HomeLoaded(albums));
    } catch (e) {
      emit(HomeError("Failed to load albums: $e"));
    }
  }
}
