import 'package:flutter/material.dart';
import 'package:sonata/screens/explore.dart';
import 'package:sonata/screens/play_song.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../constants.dart';
import 'library.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: getAppBar(theme),
      body: getPage(),
      backgroundColor: theme.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            index=value;
          });
        },
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        elevation: 10,
        backgroundColor: theme.bottomAppBarColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Explore"),
        ],
      ),
    );
  }

  getPage() {
    if (index==0)
      return Library();
    else if (index == 1)
      return Explore();
  }
}
