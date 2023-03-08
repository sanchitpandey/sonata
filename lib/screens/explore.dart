import 'package:flutter/material.dart';
import 'package:sonata/screens/play_song.dart';
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
    ThemeData _theme = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Text(
            'Explore',
            style: _textTheme.headline5,
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search songs, artists, or genres',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: _theme.cardColor,
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16.0),
          _searchController.text.isNotEmpty
              ? _buildSongs(_searchResults)
              : _buildSongs(songs),
        ],
      ),
    );
  }
  
  Widget returnGrid(List<Song> list){
    return Container(
      height: 800,
      child: GridView.builder(
        itemCount: list.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (BuildContext context, int index) {
          final song = list[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicPlayerScreen(song: song)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      song.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSongs(List<Song> list) {
    return returnGrid(list);
  }
}
