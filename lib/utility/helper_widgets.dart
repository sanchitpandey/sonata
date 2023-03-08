import 'package:flutter/material.dart';
import 'package:sonata/utility/theme_manager.dart';

import '../constants.dart';

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

Widget addHeight(double height){
  return SizedBox(height: height);
}

Widget addWidth(double width){
  return SizedBox(width: width);
}

PreferredSizeWidget getAppBar(ThemeData _theme){
  return AppBar(toolbarHeight: 80,
    backgroundColor: _theme.appBarTheme.backgroundColor,
    title: getLogo(30),
    actions: [
      Switch(
          value: themeManager.themeMode == ThemeMode.dark,
          onChanged: (isDark) {
            themeManager.toggleTheme(isDark);
          })
    ],
  );
}

Widget getLogo(double size){
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Rhythm',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            letterSpacing: size *.12,
            shadows: const [
              Shadow(
                offset: Offset(2.0, 2.0),
                color: Color(0xFFffcc33),
                blurRadius: 0.0,
              ),
            ],
          ),
        ),
        TextSpan(
          text: 'Co',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            letterSpacing: size *.12,
            color: const Color(0xFFffcc33),
            shadows: const [
              Shadow(
                offset: Offset(0.0, 0.0),
                color: Color(0xFFffcc33),
                blurRadius: 4.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );

}