import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/mock/songs_mock.dart';
import 'package:russian_spotify_project/presentation/views/layout/main_scaffold.dart';

import '../../data/dto/song.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';

  List<Song> get filteredSongs {
    if (query.isEmpty) {
      return []; // <-- пусто, если ничего не введено
    }
    final lowerQuery = query.toLowerCase();
    return songsMock.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
          song.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Search', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black, // Черный фон для всего тела
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar (now functional)
            TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for songs, artists...',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ), // Белый текст в подсказке
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ), // Белая иконка
                filled: true,
                fillColor:
                    Colors.grey[900], // Темный цвет фона для текстового поля
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
              ), // Белый цвет текста в поле
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  filteredSongs.isEmpty
                      ? const Center(
                        child: Text(
                          'No matching songs found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ) // Белый текст для сообщения
                      : ListView.builder(
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
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
                                color: Colors.white, // Белый цвет текста
                              ),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: const TextStyle(
                                color: Colors.white,
                              ), // Белый цвет текста
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
