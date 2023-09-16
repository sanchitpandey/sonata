import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/utility/app_theme.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../components/song_model.dart';

class MusicPlayerScreen extends StatefulWidget {
  List<Song> playlist;
  int currentSongIndex;

  MusicPlayerScreen({
    Key? key,
    required this.playlist,
    required this.currentSongIndex,
  }) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final player = AudioPlayer();
  late Duration duration, position;
  late bool isPlaying, isLoading=true;

  void initAudio() async {
    final song = widget.playlist[widget.currentSongIndex];
    await player.setSource(UrlSource(song.url));
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
    player.onPlayerComplete.listen((event) {
      onComplete();
      setState(() {
        if (widget.currentSongIndex < widget.playlist.length - 1) {
          //widget.currentSongIndex+=1;
          //player.setSource(UrlSource(widget.playlist[widget.currentSongIndex].url));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayerScreen(
                playlist: widget.playlist,
                currentSongIndex: widget.currentSongIndex + 1,
              ),
            ),
          );
        }
      });
    });
  }

  void onComplete() {
    isPlaying = false;
    player.stop();
    position = Duration.zero;
  }

  @override
  void initState() {
    super.initState();
    duration = Duration.zero;
    position = Duration.zero;
    isPlaying = false;
    isLoading = true;
    initAudio();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final song = widget.playlist[widget.currentSongIndex];
    return Scaffold(
      appBar: getAppBar(theme),
      backgroundColor: theme.backgroundColor,
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
          addHeight(32),
          Text(
            song.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(song.artist+"  /  "+song.genre,
                style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: playerIconSize*.75,
                icon: const Icon(
                  Icons.shuffle,
                ),
                onPressed: shufflePlaylist,
              ),
              IconButton(
                iconSize: playerIconSize,
                icon: const Icon(
                  Icons.skip_previous,
                ),
                onPressed: widget.currentSongIndex > 0
                    ? () {
                        // Play the previous song in the playlist
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayerScreen(
                              playlist: widget.playlist,
                              currentSongIndex: widget.currentSongIndex - 1,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
              isLoading? getIndicator():IconButton(
                iconSize: playerIconSize*1.5,
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                ),
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      player.pause();
                      isPlaying = false;
                    } else {
                      player.resume();
                      isPlaying = true;
                    }
                  });
                },
              ),
              IconButton(
                iconSize: playerIconSize,
                icon: const Icon(
                  Icons.skip_next,
                ),
                onPressed: widget.currentSongIndex < widget.playlist.length - 1
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayerScreen(
                              playlist: widget.playlist,
                              currentSongIndex: widget.currentSongIndex + 1,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(printDuration(position), style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
                Text(printDuration(duration), style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Slider(
              activeColor: AppTheme.darkTheme.primaryColor,
              inactiveColor: theme.primaryColorLight,
              max: duration.inMilliseconds.toDouble(),
              value: position.inMilliseconds.toDouble(),
              min: 0,
              onChanged: (value) {
                player.seek(Duration(milliseconds: value.toInt()));
              },
            ),
          ),
        ],
      ),
    );
  }

  void shufflePlaylist() {
    setState(() {
      widget.playlist.shuffle();
      log(widget.playlist.toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MusicPlayerScreen(
            playlist: widget.playlist,
            currentSongIndex: 0,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
