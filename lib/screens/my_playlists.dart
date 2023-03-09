import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sonata/components/playlist_model.dart';
import 'package:sonata/components/playlist_tile.dart';
import 'package:sonata/screens/liked_playlist.dart';
import 'package:sonata/screens/playlist_screen.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../constants.dart';

class MyPlaylists extends StatefulWidget {
  const MyPlaylists({Key? key}) : super(key: key);

  @override
  State<MyPlaylists> createState() => _MyPlaylistsState();
}

class _MyPlaylistsState extends State<MyPlaylists> {
  List<Playlist> playlistData = [];

  Widget getNameDialog(BuildContext context) {
    TextEditingController _nameController = TextEditingController();

    return Dialog(
      backgroundColor: theme.canvasColor,
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Create new Playlist",
              style: theme.textTheme.headline4,
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name of Playlist',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: theme.dialogBackgroundColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                playlists.add({
                  'name': _nameController.text.toString(),
                  'created_by': user?.uid,
                  'songIds': <String>[],
                  'imageUrl': '',
                }).then((value) {
                  getData();
                  Fluttertoast.showToast(msg: "Added");
                  Navigator.of(context).pop();
                });
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  void getData() {
    playlistData.clear();
    playlists.where('created_by', isEqualTo: user?.uid).get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        log(doc.data().toString());
        playlistData.add(Playlist.fromJson(doc));
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Playlists',
                style: _textTheme.headline3,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LikedPlaylists()));
                },
                child: Material(
                  elevation: 4,
                  color: theme.dialogBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                        size: playerIconSize - 10,
                        Icons.bookmark_border_rounded),
                  ),
                ),
              ),
              addWidth(30),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return getNameDialog(context);
                      });
                },
                child: Material(
                  elevation: 4,
                  color: theme.dialogBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(size: playerIconSize - 10, Icons.add)),
                ),
              ),
            ],
          ),
          addHeight(20),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: playlistData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaylistScreen(
                                    playlist: playlistData[index])));
                        setState(() {});
                      },
                      child: PlaylistTile(playlist: playlistData[index]));
                }),
          ),
        ],
      ),
    );
  }
}
