import 'song.dart';

class Playlist {
  final int id;
  final String title;
  final List<Song> songs;

  Playlist({required this.id, required this.title, required this.songs});

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      songs:
          (map['songs'] as List)
              .map((songMap) => Song.fromMap(Map<String, String>.from(songMap)))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'songs': songs.map((song) => song.toMap()).toList(),
    };
  }
}
