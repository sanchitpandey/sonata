import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sonata/components/playlist_model.dart';
import 'package:sonata/components/song_model.dart';
import 'package:sonata/screens/home.dart';
import 'package:sonata/screens/play_song.dart';
import 'package:sonata/screens/song_adding.dart';

import '../constants.dart';
import '../utility/helper_widgets.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistScreen({Key? key, required this.playlist}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playlist = widget.playlist;

    return Scaffold(
      appBar: getAppBar(theme),
      backgroundColor: theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          addHeight(20),
          GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              final Reference storageRef = _storage
                  .ref()
                  .child('folderName/${DateTime.now().toString()}');
              final UploadTask uploadTask =
                  storageRef.putFile(File(pickedFile!.path));
              final TaskSnapshot downloadUrl =
                  (await uploadTask.whenComplete(() {}));

              final String url = (await downloadUrl.ref.getDownloadURL());
              playlists.doc(playlist.id).update({'imageUrl': url}).then(
                  (value) { Fluttertoast.showToast(msg: "Uploaded");setState(() {

                  });});
            },
            child: Image.network(
              height: 250,
              playlist.imageUrl.isEmpty
                  ? songs[0].coverImage
                  : playlist.imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              playlist.name,
              style: theme.textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.primaryColorLight,
                ),
                child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () =>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MusicPlayerScreen(
                            playlist: playlist.getSongList(),
                            currentSongIndex: 0,
                          ))),
                ),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: MaterialButton(
                  color: theme.primaryColorLight,
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddSongsScreen(playlist: playlist)));
                    setState(() {});
                    playlists
                        .doc(playlist.id)
                        .set(playlist.toFirestore())
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(size: 30, Icons.add),
                      Text(
                        "Add Song",
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          addHeight(20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: playlist.songIds.length,
              itemBuilder: (context, index) {
                final songId = int.parse(playlist.songIds[index]) - 1;
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    leading: Image.network(songs[songId].coverImage),
                    title: Text(
                      songs[songId].title,
                      style: theme.textTheme.bodyText1,
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MusicPlayerScreen(
                                  playlist: playlist.getSongList(),
                                  currentSongIndex: index,
                                ))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
