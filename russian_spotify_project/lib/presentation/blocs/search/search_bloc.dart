import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/search_songs_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchSongsUseCase _searchSongsUseCase;

  SearchBloc(this._searchSongsUseCase) : super(SearchInitial()) {
    on<UpdateQuery>(_updateQuery);
  }

  Future<void> _updateQuery(
    UpdateQuery event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final songs = await _searchSongsUseCase(event.query);
      emit(SearchLoaded(songs));
    } catch (e) {
      emit(SearchError("Failed to search songs: $e"));
    }
  }
}
