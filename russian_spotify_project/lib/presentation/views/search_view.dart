import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/songs_mock.dart';
import 'package:russian_spotify_project/presentation/views/layout/main_scaffold.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';

  List<Map<String, String>> get filteredSongs {
    if (query.isEmpty) {
      return []; // <-- пусто, если ничего не введено
    }
    final lowerQuery = query.toLowerCase();
    return songsMock.where((song) {
      return song['title']!.toLowerCase().contains(lowerQuery) ||
          song['artist']!.toLowerCase().contains(lowerQuery);
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
      body: Padding(
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
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredSongs.isEmpty
                  ? const Center(child: Text('No matching songs found.'))
                  : ListView.builder(
                itemCount: filteredSongs.length,
                itemBuilder: (context, index) {
                  final song = filteredSongs[index];
                  return ListTile(
                    leading: const Icon(Icons.music_note, color: Colors.purple, size: 30),
                    title: Text(song['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(song['artist']!),
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
