import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_event.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_state.dart';
import '../views/layout/main_scaffold.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        // Дополнительные действия при изменении состояния (если нужны)
      },
      builder: (context, state) {
        return MainScaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text('Search', style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) {
                    context.read<SearchBloc>().add(UpdateQuery(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for songs, artists...',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child:
                      state is SearchLoading
                          ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.purple,
                              ),
                            ),
                          )
                          : state is SearchLoaded
                          ? state.songs.isEmpty
                              ? const Center(
                                child: Text(
                                  'No matching songs found.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                              : ListView.builder(
                                itemCount: state.songs.length,
                                itemBuilder: (context, index) {
                                  final song = state.songs[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.music_note,
                                      color: Colors.purple,
                                      size: 30,
                                    ),
                                    title: Text(
                                      song.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      song.artist,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              )
                          : const Center(
                            child: Text(
                              'Unknown error',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
