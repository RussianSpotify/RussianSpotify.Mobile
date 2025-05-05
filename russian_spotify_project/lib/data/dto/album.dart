class Album {
  final String title;
  final String artist;

  Album({required this.title, required this.artist});

  factory Album.fromMap(Map<String, String> map) {
    return Album(title: map['title'] ?? '', artist: map['artist'] ?? '');
  }

  Map<String, String> toMap() {
    return {'title': title, 'artist': artist};
  }
}
