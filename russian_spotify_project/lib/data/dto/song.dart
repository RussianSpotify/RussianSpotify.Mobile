class Song {
  final String title;
  final String artist;

  Song({required this.title, required this.artist});

  factory Song.fromMap(Map<String, String> map) {
    return Song(title: map['title'] ?? '', artist: map['artist'] ?? '');
  }

  Map<String, String> toMap() {
    return {'title': title, 'artist': artist};
  }
}
