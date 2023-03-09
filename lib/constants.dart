import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonata/utility/app_theme.dart';
import 'package:sonata/utility/theme_manager.dart';

import 'components/song_model.dart';

Color bgColor = const Color(0xff191825);
Color primaryColor = const Color(0xFF865DFF);
Color lightColor = const Color(0xFFE5D4ED);

final ThemeManager themeManager = ThemeManager();

double playerIconSize = 50;

// Fonts
TextStyle kBaseFont = const TextStyle(fontSize: 24, fontFamily: 'RaleWay');

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = auth.currentUser!;
CollectionReference playlists =
FirebaseFirestore.instance.collection('playlists');

List<Song> songs = [
  Song(
    id: '1',
    title: 'Shape of You',
    artist: 'Ed Sheeran',
    genre: 'Pop',
    album: '÷ (Deluxe)',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/b/b4/Shape_Of_You_%28Official_Single_Cover%29_by_Ed_Sheeran.png',
    url: 'https://fine.sunproxy.net/file/eERFeCtNR1k3RmhtRUpyK0ZPdGNBL3hzYUdUdXcra21EcHNaTHdVNWN2cFBhRHNldkxtZU5jWklpRjhNcW03TkRxc3d4YmxNcmh1YmI1VU1heWlrczBZV2VlNlVzc2FLRlNMTzB4TVFxOVk9/Ed_Sheeran_-_Shape_of_You_(ColdMP3.com).mp3',
  ),
  Song(
    id: '2',
    title: 'Blinding Lights',
    artist: 'The Weeknd',
    genre: 'R&B/Soul',
    album: 'After Hours',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png',
    url:
        'https://fine.sunproxy.net/file/eERFeCtNR1k3RmhtRUpyK0ZPdGNBL3hzYUdUdXcra21EcHNaTHdVNWN2cVNNSlhLeU01M0o0Vlk4Rk1aWWg0OUV0dkpKbU5FQU1tVlUxTkI4b29FOWl5bU1KZElzYXg0MWpSQ1VKZ2ZSV0E9/The_Weeknd_-_Blinding_Lights_(ColdMP3.com).mp3',
  ),
  Song(
    id: '3',
    title: 'Don\'t Start Now',
    artist: 'Dua Lipa',
    genre: 'Pop',
    album: 'Future Nostalgia',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/2/2b/Dua_Lipa_-_Don%27t_Start_Now.png',
    url: 'https://fine.sunproxy.net/file/eERFeCtNR1k3RmhtRUpyK0ZPdGNBL3hzYUdUdXcra21EcHNaTHdVNWN2cVNNSlhLeU01M0o0Vlk4Rk1aWWg0OTVFOTlzSW4zcFc4M2JFNjRRQ2E1Y3NqR2ZHUUVyd243cDR4WU5jZ01IUGc9/Dua_Lipa_-_Don_t_Start_Now_(ColdMP3.com).mp3',
  ),
  Song(
    id: '4',
    title: 'Watermelon Sugar',
    artist: 'Harry Styles',
    genre: 'Pop',
    album: 'Fine Line',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/b/bf/Watermelon_Sugar_-_Harry_Styles.png',
    url: 'https://naasongs.vip/myuploads/uploads/English%20Songs/Watermelon%20Sugar.mp3',
  ),
  Song(
    id: '5',
    title: 'Levitating (feat. DaBaby)',
    artist: 'Dua Lipa',
    genre: 'Pop',
    album: 'Future Nostalgia',
    coverImage:
        'https://i.scdn.co/image/ab67616d0000b273bd26ede1ae69327010d49946',
    url: 'https://newdjsongremix.com/files/download/type/128/id/1493',
  ),
  Song(
    id: '6',
    title: 'Drivers License',
    artist: 'Olivia Rodrigo',
    genre: 'Pop',
    album: 'Drivers License',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/0/09/Drivers_License_by_Olivia_Rodrigo.png',
    url: 'https://db.soloplay.com.ng/wp-content/uploads/2021/02/Olivia_Rodrigo_-_Drivers_License_Soloplay.ng.mp3',
  ),
];

ThemeData theme = AppTheme.lightTheme;