import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sonata/screens/playlist_screen.dart';

import '../components/playlist_model.dart';
import '../components/playlist_tile.dart';
import '../constants.dart';
import '../utility/helper_widgets.dart';

class LikedPlaylists extends StatefulWidget {
  const LikedPlaylists({Key? key}) : super(key: key);

  @override
  State<LikedPlaylists> createState() => _LikedPlaylistsState();
}

class _LikedPlaylistsState extends State<LikedPlaylists> {
  List<Playlist> likedPlaylist = [];
  bool isLoading = true;

  void getLikedPlaylist() async{
    users.doc(user?.uid).get().then((value) {
      List liked = (value.get('liked'));
      likedPlaylist.clear();

      for (String likedID in liked){
        playlists.doc(likedID).get().then((value){
          likedPlaylist.add(Playlist.fromJson(value));
          setState(() {
            isLoading = false;
          });
        });
      }


    });
  }

  @override
  void initState() {
    super.initState();
    getLikedPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    TextTheme _textTheme = theme.textTheme;
    log(likedPlaylist.toString());

    return Scaffold(
      appBar: getAppBar(theme),
      backgroundColor: theme.backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Liked Playlists',
                  style: _textTheme.headline3,
                ),
              ],
            ),
            addHeight(20),
            isLoading?getIndicator():Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: likedPlaylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaylistScreen(
                                      playlist: likedPlaylist[index])));
                          setState(() {});
                        },
                        child: PlaylistTile(playlist: likedPlaylist[index]));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
