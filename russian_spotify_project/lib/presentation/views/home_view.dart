import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/mock/albums_mock.dart';

import 'layout/main_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
        color: Colors.black, // Устанавливаем черный фон
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Irek!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Белый цвет текста
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: albumsMock.length,
                itemBuilder: (context, index) {
                  final album = albumsMock[index];
                  return Card(
                    color: Colors.grey.withValues(alpha: 0.1),
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
                                  color: Colors.white, // Белый цвет текста
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                album.artist,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white, // Белый цвет текста
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
  }
}
