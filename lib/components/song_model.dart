import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  String id;
  String title;
  String artist;
  String genre;
  String album;
  String coverImage;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.genre,
    required this.album,
    required this.coverImage,
  });

  factory Song.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Song(
      id: doc.id,
      title: data['title'],
      artist: data['artist'],
      genre: data['genre'],
      album: data['album'],
      coverImage: data['coverImage'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'artist': artist,
      'genre': genre,
      'album': album,
      'coverImage': coverImage,
    };
  }
}
