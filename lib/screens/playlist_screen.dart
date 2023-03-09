import 'package:flutter/material.dart';
import 'package:sonata/components/playlist_model.dart';

import '../constants.dart';
import '../utility/helper_widgets.dart';

class PlaylistScreen extends StatefulWidget {
  Playlist playlist;

  PlaylistScreen({super.key, required this.playlist});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
        appBar: getAppBar(theme),
    backgroundColor: theme.backgroundColor,
    );
  }
}
