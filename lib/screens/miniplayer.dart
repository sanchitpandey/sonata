import 'package:flutter/material.dart';
import 'package:sonata/components/song_model.dart';

class MiniPlayer extends StatefulWidget {
  Song song;
  final VoidCallback onPlayPressed;
  final VoidCallback onPausePressed;

  MiniPlayer({
    required this.song,
    required this.onPlayPressed,
    required this.onPausePressed,
  });

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to full screen player when mini player is clicked
      },
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
                if (isPlaying) {
                  widget.onPlayPressed();
                } else {
                  widget.onPausePressed();
                }
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.song.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.song.artist,
                    style: TextStyle(
                      fontSize: 14,
                    ),
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
