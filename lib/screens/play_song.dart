import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../components/song_model.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final player = AudioPlayer();
  Duration duration = Duration(minutes: 0), position = Duration(minutes: 0);
  bool isPlaying = false, isLoading = true;

  void initAudio() async {
    await player.setSource(UrlSource(widget.song.url));
    setState(() {
      isLoading = false;
      player.resume();
      isPlaying = true;
    });
    player.onDurationChanged.listen((Duration d) {
      setState(() => duration = d);
    });
    player.onPositionChanged
        .listen((Duration p) => {setState(() => position = p)});
  }

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.song.coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          addHeight(32),
          Text(
            widget.song.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.song.artist,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: playerIconSize,
                icon: const Icon(
                  Icons.skip_previous,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 32),
              isLoading?CircularProgressIndicator(backgroundColor: theme.primaryColor, valueColor: null, color: theme.dialogBackgroundColor,):IconButton(
                iconSize: playerIconSize,
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                ),
                onPressed: () {
                  if (isPlaying)
                    {
                      player.pause();
                      isPlaying = false;
                    }
                  else
                  {
                    player.resume();
                    isPlaying = true;
                  }
                  setState(() {

                  });
                },
              ),
              const SizedBox(width: 32),
              IconButton(
                iconSize: playerIconSize,
                icon: const Icon(
                  Icons.skip_next,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(printDuration(position)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  height: 4,
                  child: const LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text(printDuration(duration)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
