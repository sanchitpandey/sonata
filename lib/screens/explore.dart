import 'package:flutter/material.dart';
import 'package:sonata/screens/play_song.dart';
import 'package:sonata/utility/app_theme.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../components/song_model.dart';
import '../constants.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  TextEditingController _searchController = TextEditingController();

  List<Song> _searchResults = [];

  void _searchSongs(String query) {
    setState(() {
      _searchResults = songs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()) ||
              song.genre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    _searchController.addListener(() {
      _searchSongs(_searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore',
            style: _textTheme.headline3,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search songs, artists, or genres',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: theme.dialogBackgroundColor,
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 20.0),
          _searchController.text.isNotEmpty
              ? returnGrid(_searchResults)
              : returnGrid(songs),
        ],
      ),
    );
  }
  
  Widget returnGrid(List<Song> list,){
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          childAspectRatio: 0.67,
        ),
        itemBuilder: (BuildContext context, int index) {
          final song = list[index];
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicPlayerScreen(playlist: [song], currentSongIndex: 0,)));
              },
              child: Material(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.dialogBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            song.coverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      addHeight(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          song.title,
                          style: theme.textTheme.headline5,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          song.artist,
                          style: theme.textTheme.bodyText2?.copyWith(color: theme.brightness==AppTheme.darkTheme.brightness?Colors.white60:Colors.black.withOpacity(.7)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      addHeight(5),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
