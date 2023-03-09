import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sonata/components/playlist_model.dart';
import 'package:sonata/components/playlist_tile.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../constants.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Playlist> playlistData = [];

  Widget getNameDialog(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    bool inProgress = false;

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
                }).then((value) {
                  getData();
                  SnackBar(content: Text("Added"),);
                  Navigator.of(context).pop();
                });
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  void getData() {
    playlistData.clear();
    playlists.where('created_by', isEqualTo: user?.uid).get().then((value) {
      for (DocumentSnapshot doc in value.docs){
        playlistData.add(Playlist.fromJson(doc));
      }
      setState(() {

      });
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
      margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Playlists',
                style: _textTheme.headline3,
              ),
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Icon(size: playerIconSize, Icons.add),
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
                  return PlaylistTile(playlist: playlistData[index]);
                }),
          ),
        ],
      ),
    );
  }
}
