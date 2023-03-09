import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sonata/screens/playlist_screen.dart';

import '../components/playlist_model.dart';
import '../components/playlist_tile.dart';
import '../constants.dart';
import '../utility/helper_widgets.dart';

class AllPlaylists extends StatefulWidget {
  const AllPlaylists({Key? key}) : super(key: key);

  @override
  State<AllPlaylists> createState() => _AllPlaylistsState();
}

class _AllPlaylistsState extends State<AllPlaylists> {
  List<Playlist> allPlaylist = [];
  bool isLoading = true;

  void getAllPlaylists() async {
    playlists.get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        allPlaylist.add(Playlist.fromJson(doc));
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    TextTheme _textTheme = theme.textTheme;
    log(allPlaylist.toString());

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
            ],
          ),
          addHeight(20),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allPlaylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                          playlist: allPlaylist[index])));
                              setState(() {});
                            },
                            child: PlaylistTile(playlist: allPlaylist[index]));
                      }),
                ),
        ],
      ),
    );
  }
}
