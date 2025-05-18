import 'package:russian_spotify_project/domain/entities/author_entity.dart';
import 'package:russian_spotify_project/domain/entities/category_entity.dart';

class Song {
  final String id;
  final String songName;
  final double duration;
  final int playsNumber;
  final Category category;
  final String? imageFileId;
  final String? songFileId;
  final List<Author> authors;

  Song({
    required this.id,
    required this.songName,
    required this.duration,
    required this.playsNumber,
    required this.category,
    this.imageFileId,
    this.songFileId,
    required this.authors,
  });

  /// Создание объекта из JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      songName: json['songName'],
      duration: json['duration'].toDouble(),
      playsNumber: json['playsNumber'],
      category: Category.fromJson(json['category']),
      imageFileId: json['imageFileId'] != null ? json['imageFileId'] : null,
      songFileId: json['songFileId'] != null ? json['songFileId'] : null,
      authors:
          (json['authors'] as List)
              .map((authorJson) => Author.fromJson(authorJson))
              .toList(),
    );
  }

  /// Преобразование объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songName': songName,
      'duration': duration,
      'playsNumber': playsNumber,
      'category': category.toJson(), // Преобразуем категорию в JSON
      'imageFileId': imageFileId,
      'songFileId': songFileId,
      'authors':
          authors
              .map((author) => author.toJson())
              .toList(), // Преобразуем авторов в JSON
    };
  }
}
