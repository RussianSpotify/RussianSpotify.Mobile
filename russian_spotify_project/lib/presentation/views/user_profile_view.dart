import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_state.dart';
import '../../presentation/widgets/song/song_list_widget.dart';
import '../views/layout/main_scaffold.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        // Дополнительные действия при изменении состояния (если нужны)
      },
      builder: (context, state) {
        if (state is UserProfileInitial) {
          context.read<UserProfileBloc>().add(LoadFavoriteSongs());
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        } else if (state is UserProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        } else if (state is UserProfileLoaded) {
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
                        backgroundImage: AssetImage(
                          'assets/mock/profile_photo.png',
                        ),
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
                        state.favoriteSongs.isEmpty
                            ? const Center(
                              child: Text(
                                'No favorite songs yet',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                            : SongListWidget(songs: state.favoriteSongs),
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserProfileError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown state', style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }
}
