import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/home/home_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/home/home_event.dart';
import 'package:russian_spotify_project/presentation/blocs/home/home_state.dart';
import '../views/layout/main_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // Дополнительные действия при изменении состояния (если нужны)
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          // Запускаем загрузку альбомов
          context.read<HomeBloc>().add(LoadAlbums());
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        } else if (state is HomeLoading) {
          // Показываем индикатор загрузки
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        } else if (state is HomeLoaded) {
          // Отображаем список альбомов
          return MainScaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: const Text(
                'Russian Spotify',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, Irek!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.albums.length,
                      itemBuilder: (context, index) {
                        final album = state.albums[index];
                        return Card(
                          color: Colors.grey.withAlpha(
                            26,
                          ), // Прозрачный серый цвет
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.album,
                                  size: 50,
                                  color: Colors.purple,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      album.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      album.artist,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomeError) {
          // Показываем сообщение об ошибке
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          // Неизвестное состояние
          return const Center(
            child: Text('Unknown state', style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }
}
