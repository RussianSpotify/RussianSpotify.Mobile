import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/di/locator.dart';
import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_event.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_state.dart';
import '../views/layout/main_scaffold.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SearchBloc>(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // Дополнительные действия при изменении состояния (если нужны)
        },
        builder: (context, state) {
          return MainScaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  /// Построение AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      title: const Text('Search', style: _whiteTextStyle),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  /// Построение основного контента
  Widget _buildBody(BuildContext context, SearchState state) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSearchBar(context),
          const SizedBox(height: 20),
          Expanded(child: _buildContent(state)),
        ],
      ),
    );
  }

  /// Построение строки поиска
  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<SearchBloc>().add(UpdateQuery(value));
      },
      decoration: InputDecoration(
        hintText: 'Search for songs, artists...',
        hintStyle: _hintTextStyle, // Используем стиль подсказки
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: _whiteTextStyle,
    );
  }

  /// Построение содержимого в зависимости от состояния
  Widget _buildContent(SearchState state) {
    if (state is SearchLoading) {
      return _buildLoadingIndicator();
    } else if (state is SearchLoaded) {
      return state.songs.isEmpty
          ? _buildEmptyResultMessage()
          : _buildSongList(state.songs);
    } else if (state is SearchError) {
      return _buildErrorMessage(state.errorMessage);
    } else {
      return _buildUnknownErrorMessage();
    }
  }

  /// Индикатор загрузки
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
      ),
    );
  }

  /// Сообщение об отсутствии результатов
  Widget _buildEmptyResultMessage() {
    return const Center(
      child: Text(
        'No matching songs found.',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  /// Список песен
  Widget _buildSongList(List<Song> songs) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          leading: const Icon(Icons.music_note, color: Colors.purple, size: 30),
          title: Text(
            song.songName, // Используем songName из модели Song
            style: _boldWhiteTextStyle,
          ),
          subtitle: Text(
            song.authors
                .map((author) => author.userName)
                .join(', '), // Объединяем имена авторов
            style: _whiteTextStyle,
          ),
        );
      },
    );
  }

  /// Сообщение об ошибке
  Widget _buildErrorMessage(String errorMessage) {
    return Center(
      child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
    );
  }

  /// Сообщение о неизвестной ошибке
  Widget _buildUnknownErrorMessage() {
    return const Center(
      child: Text('Unknown error', style: TextStyle(color: Colors.red)),
    );
  }

  /// Стиль текста (белый)
  static const TextStyle _whiteTextStyle = TextStyle(color: Colors.white);

  /// Жирный белый текст
  static const TextStyle _boldWhiteTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Стиль подсказки (серый)
  static const TextStyle _hintTextStyle = TextStyle(
    color: Colors.white70, // Серый цвет для подсказки
  );
}
