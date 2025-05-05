import 'package:flutter/material.dart';
import 'package:russian_spotify_project/core/utils/app_routes.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final PreferredSizeWidget?
  appBar; // <-- добавляем возможность передать свой appBar

  const MainScaffold({
    super.key,
    required this.body,
    this.title = 'Russian Spotify',
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar ??
          AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              'Russian Spotify',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              color: Colors.purple,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Меню',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music),
              title: const Text('Your Library'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.myLibrary);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About us'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
