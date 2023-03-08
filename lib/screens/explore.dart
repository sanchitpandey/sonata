import 'package:flutter/material.dart';
import 'package:sonata/utility/helper_widgets.dart';

import '../components/song_model.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Song> songs = [
    Song(
      id: '1',
      title: 'Shape of You',
      artist: 'Ed Sheeran',
      genre: 'Pop',
      album: '÷ (Deluxe)',
      coverImage:
          'https://upload.wikimedia.org/wikipedia/en/b/b4/Shape_Of_You_%28Official_Single_Cover%29_by_Ed_Sheeran.png',
    ),
    Song(
      id: '2',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      genre: 'R&B/Soul',
      album: 'After Hours',
      coverImage:
          'https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png',
    ),
    Song(
      id: '3',
      title: 'Don\'t Start Now',
      artist: 'Dua Lipa',
      genre: 'Pop',
      album: 'Future Nostalgia',
      coverImage:
          'https://i.scdn.co/image/ab67616d0000b2731846a84455b317447c6e7b01',
    ),
    Song(
      id: '4',
      title: 'Watermelon Sugar',
      artist: 'Harry Styles',
      genre: 'Pop',
      album: 'Fine Line',
      coverImage:
          'https://i.scdn.co/image/ab67616d0000b2731e1e80ab50e7b5f27d45ccbb',
    ),
    Song(
      id: '5',
      title: 'Levitating (feat. DaBaby)',
      artist: 'Dua Lipa',
      genre: 'Pop',
      album: 'Future Nostalgia',
      coverImage:
          'https://i.scdn.co/image/ab67616d0000b273d9e9c1a4306e70260ce4d4a4',
    ),
    Song(
      id: '6',
      title: 'Drivers License',
      artist: 'Olivia Rodrigo',
      genre: 'Pop',
      album: 'Drivers License',
      coverImage:
          'https://i.scdn.co/image/ab67616d0000b273c4066bb0e8b7da6e01fe35c7',
    ),
  ];

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
          return Container(
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
          );
        },
      ),
    );
  }

  Widget _buildSongs(List<Song> list) {
    return returnGrid(list);
  }
}
