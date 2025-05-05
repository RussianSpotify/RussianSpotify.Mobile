import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/viewmodels/user_profile_viewmodel.dart';
import 'package:russian_spotify_project/presentation/widgets/song/song_list_widget.dart';

import 'layout/main_scaffold.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserProfileViewModel>(context);
    viewModel.loadFavoriteSongs();

    return MainScaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/mock/profile_photo.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Irek',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'Favorite Songs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child:
                  viewModel.favoriteSongs.isEmpty
                      ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.purple,
                          ),
                        ),
                      )
                      : SongListWidget(
                        songs: viewModel.favoriteSongs,
                      ), // Передаем список песен
            ),
          ],
        ),
      ),
    );
  }
}
