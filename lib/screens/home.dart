import 'package:flutter/material.dart';
import 'package:sonata/screens/explore.dart';
import 'package:sonata/screens/play_song.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    int _index = 0;

    return Scaffold(
      appBar: getAppBar(_theme),
      body: SingleChildScrollView(
        child: getPage(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BottomNavigationBar(
          onTap: (value){
            setState(() {
              _index=value;
            });
          },
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          elevation: 5,
          backgroundColor: _theme.bottomAppBarColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Explore"),
          ],
        ),
      ),
    );
  }

  getPage() {
    //return MusicPlayerScreen(song: songs[1]);
    return Explore();
  }
}
