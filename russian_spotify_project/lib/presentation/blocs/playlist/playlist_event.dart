abstract class PlaylistEvent {}

class LoadPlaylist extends PlaylistEvent {
  final int playlistId;

  LoadPlaylist(this.playlistId);
}
