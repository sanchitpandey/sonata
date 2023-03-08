import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonata/utility/theme_manager.dart';

Color bgColor = const Color(0xff191825);
Color primaryColor = const Color(0xFF865DFF);
Color lightColor = const Color(0xFFE5D4ED);

final ThemeManager themeManager = ThemeManager();

// Fonts
TextStyle kBaseFont = const TextStyle(fontSize: 24, fontFamily: 'RaleWay');

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = auth.currentUser!;
