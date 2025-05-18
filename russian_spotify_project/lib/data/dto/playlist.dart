import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/domain/entities/author_entity.dart';

/// Модель плейлиста или альбома
class Playlist {
  final String id; // Уникальный идентификатор плейлиста
  final String playlistName; // Название плейлиста
  final String? imageFileId; // Идентификатор изображения (опционально)
  final String authorId; // Идентификатор автора
  final Author? author; // Автор плейлиста (опционально)
  final DateTime releaseDate; // Дата публикации
  final int playsNumber; // Количество прослушиваний
  final List<Song> songs; // Список песен в плейлисте
  final bool isAlbum; // Является ли плейлист альбомом
  final DateTime createdAt; // Дата создания
  final DateTime? updatedAt; // Дата обновления (опционально)
  final bool isDeleted; // Флаг удаления
  final DateTime? deletedAt; // Дата удаления (опционально)

  Playlist({
    required this.id,
    required this.playlistName,
    this.imageFileId,
    required this.authorId,
    this.author,
    required this.releaseDate,
    required this.playsNumber,
    required this.songs,
    required this.isAlbum,
    required this.createdAt,
    this.updatedAt,
    required this.isDeleted,
    this.deletedAt,
  });

  /// Создание объекта из JSON
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      playlistName: json['playlistName'],
      imageFileId: json['imageFileId'] != null ? (json['imageFileId']) : null,
      authorId: (json['authorId']),
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      releaseDate: DateTime.parse(json['releaseDate']),
      playsNumber: json['playsNumber'],
      songs:
          (json['songs'] as List)
              .map((songJson) => Song.fromJson(songJson))
              .toList(),
      isAlbum: json['isAlbum'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isDeleted: json['isDeleted'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  /// Преобразование объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playlistName': playlistName,
      'imageFileId': imageFileId?.toString(),
      'authorId': authorId.toString(),
      'author': author?.toJson(),
      'releaseDate': releaseDate.toIso8601String(),
      'playsNumber': playsNumber,
      'songs': songs.map((song) => song.toJson()).toList(),
      'isAlbum': isAlbum,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
