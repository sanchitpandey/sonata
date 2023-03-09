import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonata/components/song_model.dart';

import '../constants.dart';

class Playlist {
  String id;
  String name;
  String imageUrl;
  List songIds;
  String createdBy;

  Playlist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.songIds,
    required this.createdBy,
  });

  List<Song> getSongList(){
    List<Song> playlist = [];
    for (String songID in songIds){
      playlist.add(songs[int.parse(songID)-1]);
    }
    return playlist;
  }

  factory Playlist.fromJson(DocumentSnapshot doc) {
    return Playlist(
        id: doc.id,
        name: doc.get('name'),
        imageUrl: doc.get('imageUrl'),
        songIds: doc.get('songIds'),
        createdBy: doc.get('created_by'));
  }

  factory Playlist.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Playlist(
      id: doc.id,
      name: data['name'],
      imageUrl: data['imageUrl'],
      songIds: List<String>.from(data['songIds']),
      createdBy: data['created_by'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'songIds': songIds,
      'created_by': createdBy,
    };
  }
}
