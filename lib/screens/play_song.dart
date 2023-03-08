import 'package:flutter/material.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../components/song_model.dart';

class MusicPlayerScreen extends StatelessWidget {
  final Song song;

  MusicPlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: getAppBar(_theme),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                song.coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(
            song.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            song.artist,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(iconSize: playerIconSize,
                icon: Icon(Icons.skip_previous,),
                onPressed: () {},
              ),
              SizedBox(width: 32),
              IconButton(iconSize: playerIconSize,
                icon: Icon(Icons.play_circle_filled,),
                onPressed: () {},
              ),
              SizedBox(width: 32),
              IconButton(iconSize: playerIconSize,
                icon: Icon(Icons.skip_next,),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0:00'),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.65,
                  height: 4,
                  child: LinearProgressIndicator(
                    value: 0.5, // TODO: replace with actual progress value
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text('3:21'), // TODO: replace with actual song duration
              ],
            ),
          ),
        ],
      ),
    );
  }
}
