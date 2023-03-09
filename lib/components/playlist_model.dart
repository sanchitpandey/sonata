import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  String id;
  String name;
  String imageUrl;
  List<String> songIds;
  String createdBy;

  Playlist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.songIds,
    required this.createdBy,
  });

  factory Playlist.fromJson(DocumentSnapshot doc) {
    return Playlist(id: doc.id, name: doc.get('name'), imageUrl: '', songIds: [], createdBy: doc.get('created_by'));
  }


  factory Playlist.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Playlist(
      id: doc.id,
      name: data['name'],
      imageUrl: data['imageUrl'],
      songIds: List<String>.from(data['songIds']),
      createdBy: data['createdBy'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'songIds': songIds,
      'createdBy': createdBy,
    };
  }
}
