import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

List<Song> songs = [
  Song(
    id: '1',
    title: 'Shape of You',
    artist: 'Ed Sheeran',
    genre: 'Pop',
    album: '÷ (Deluxe)',
    coverImage:
        'https://upload.wikimedia.org/wikipedia/en/b/b4/Shape_Of_You_%28Official_Single_Cover%29_by_Ed_Sheeran.png',
    url: '',
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
        'https://i.scdn.co/image/ab67616d0000b2731846a84455b317447c6e7b01',
    url: '',
  ),
  Song(
    id: '4',
    title: 'Watermelon Sugar',
    artist: 'Harry Styles',
    genre: 'Pop',
    album: 'Fine Line',
    coverImage:
        'https://i.scdn.co/image/ab67616d0000b2731e1e80ab50e7b5f27d45ccbb',
    url: '',
  ),
  Song(
    id: '5',
    title: 'Levitating (feat. DaBaby)',
    artist: 'Dua Lipa',
    genre: 'Pop',
    album: 'Future Nostalgia',
    coverImage:
        'https://i.scdn.co/image/ab67616d0000b273d9e9c1a4306e70260ce4d4a4',
    url: '',
  ),
  Song(
    id: '6',
    title: 'Drivers License',
    artist: 'Olivia Rodrigo',
    genre: 'Pop',
    album: 'Drivers License',
    coverImage:
        'https://i.scdn.co/image/ab67616d0000b273c4066bb0e8b7da6e01fe35c7',
    url: '',
  ),
];
