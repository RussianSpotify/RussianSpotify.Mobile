import 'package:russian_spotify_project/data/dto/playlist.dart';
import 'package:russian_spotify_project/data/dto/song.dart';

final List<Playlist> playlistsMock = [
  Playlist(
    id: 1,
    title: 'My Favorite Playlist',
    songs: [
      Song(title: 'Shape of You', artist: 'Ed Sheeran'),
      Song(title: 'Blinding Lights', artist: 'The Weeknd'),
      Song(title: 'Levitating', artist: 'Dua Lipa'),
    ],
  ),
  Playlist(
    id: 2,
    title: 'Chill Vibes',
    songs: [
      Song(title: 'Sunflower', artist: 'Post Malone, Swae Lee'),
      Song(title: 'Watermelon Sugar', artist: 'Harry Styles'),
      Song(title: 'Bad Guy', artist: 'Billie Eilish'),
    ],
  ),
  Playlist(
    id: 3,
    title: 'Workout Hits',
    songs: [
      Song(title: 'Stronger', artist: 'Kanye West'),
      Song(title: 'Eye of the Tiger', artist: 'Survivor'),
      Song(title: 'Can’t Hold Us', artist: 'Macklemore & Ryan Lewis'),
    ],
  ),
  Playlist(
    id: 4,
    title: 'Throwback Classics',
    songs: [
      Song(title: 'Billie Jean', artist: 'Michael Jackson'),
      Song(title: 'Wonderwall', artist: 'Oasis'),
      Song(title: 'Smells Like Teen Spirit', artist: 'Nirvana'),
    ],
  ),
  Playlist(
    id: 5,
    title: 'Indie Mood',
    songs: [
      Song(title: 'Electric Feel', artist: 'MGMT'),
      Song(title: 'Take Me Out', artist: 'Franz Ferdinand'),
      Song(title: 'Dog Days Are Over', artist: 'Florence + The Machine'),
    ],
  ),
];
