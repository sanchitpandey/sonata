import 'package:flutter/material.dart';

import '../components/playlist_model.dart';
import '../constants.dart';

class AddSongsScreen extends StatefulWidget {
  final Playlist playlist;

  AddSongsScreen({required this.playlist});

  @override
  _AddSongsScreenState createState() => _AddSongsScreenState();
}

class _AddSongsScreenState extends State<AddSongsScreen> {
  List<String> selectedSongIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('Add Songs'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              widget.playlist.songIds.addAll(selectedSongIds);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: CheckboxListTile(
                secondary: Image.network(
                  song.coverImage,
                  height: 150,
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                  song.title,
                  style: theme.textTheme.headline5,
                ),
                value: selectedSongIds.contains(song.id),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedSongIds.add(song.id);
                    } else {
                      selectedSongIds.remove(song.id);
                    }
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
