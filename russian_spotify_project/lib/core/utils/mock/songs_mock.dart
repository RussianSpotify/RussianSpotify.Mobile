import 'package:russian_spotify_project/data/dto/song.dart';
import 'package:russian_spotify_project/domain/entities/author_entity.dart';
import 'package:russian_spotify_project/domain/entities/category_entity.dart';

final List<Song> songsMock = [
  Song(
    id: '1',
    songName: 'Shape of You',
    duration: 233.5,
    playsNumber: 12000000,
    category: Category(id: 'c1', name: 'Pop'),
    imageFileId: 'image_1.jpg',
    songFileId: 'song_1.mp3',
    authors: [Author(id: 'a1', userName: 'Ed Sheeran')],
  ),
  Song(
    id: '2',
    songName: 'Bohemian Rhapsody',
    duration: 354.2,
    playsNumber: 8000000,
    category: Category(id: 'c2', name: 'Rock'),
    imageFileId: 'image_2.jpg',
    songFileId: 'song_2.mp3',
    authors: [Author(id: 'a2', userName: 'Queen')],
  ),
  Song(
    id: '3',
    songName: 'Blinding Lights',
    duration: 201.8,
    playsNumber: 15000000,
    category: Category(id: 'c3', name: 'Synth-pop'),
    imageFileId: 'image_3.jpg',
    songFileId: 'song_3.mp3',
    authors: [Author(id: 'a3', userName: 'The Weeknd')],
  ),
  Song(
    id: '4',
    songName: 'Rolling in the Deep',
    duration: 228.0,
    playsNumber: 9500000,
    category: Category(id: 'c1', name: 'Pop'),
    imageFileId: 'image_4.jpg',
    songFileId: 'song_4.mp3',
    authors: [Author(id: 'a4', userName: 'Adele')],
  ),
  Song(
    id: '5',
    songName: 'Hotel California',
    duration: 390.6,
    playsNumber: 7000000,
    category: Category(id: 'c2', name: 'Rock'),
    imageFileId: 'image_5.jpg',
    songFileId: 'song_5.mp3',
    authors: [Author(id: 'a5', userName: 'Eagles')],
  ),
];
