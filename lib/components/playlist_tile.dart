import 'package:flutter/material.dart';
import 'package:sonata/components/playlist_model.dart';
import 'package:sonata/screens/playlist_screen.dart';

import '../constants.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;

  PlaylistTile({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaylistScreen(playlist: playlist)));
      },
      child: Container(
        color: theme.cardColor,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Playlist Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: playlist.imageUrl.isEmpty?NetworkImage(songs[0].coverImage):NetworkImage(playlist.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Playlist Name
                  Text(
                    playlist.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // P
                  SizedBox(height: 4),
                  // Number of Songs
                  Text(
                    '${playlist.songIds.length} Songs',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
