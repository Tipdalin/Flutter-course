import 'package:flutter/material.dart';

// A mock list of jokes
final List<Map<String, String>> jokes = List.generate(
  30,
  (index) => {
    "id": index.toString(),
    "title": "Title $index",
    "description": "Description $index.",
  },
);

Color appColor = Colors.green[300] as Color;

void main() => runApp(const favoriteJoke());

class favoriteJoke extends StatelessWidget {
  const favoriteJoke({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text("Favorite Jokes"),
        ),
        body: const FavoriteJokesList(),
      ),
    );
  }
}

class FavoriteJokesList extends StatefulWidget {
  const FavoriteJokesList({super.key});

  @override
  State<FavoriteJokesList> createState() => _FavoriteJokesListState();
}

class _FavoriteJokesListState extends State<FavoriteJokesList> {
  String? _favoriteJokeId; // ID of the current favorite joke

  void setFavorite(String jokeId) {
    setState(() {
      _favoriteJokeId = jokeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];
        return FavoriteCard(
          joke: joke,
          isFavorite: joke["id"] == _favoriteJokeId,
          onFavoriteSelected: setFavorite,
        );
      },
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Map<String, String> joke;
  final bool isFavorite;
  final Function(String) onFavoriteSelected;

  const FavoriteCard({
    required this.joke,
    required this.isFavorite,
    required this.onFavoriteSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke['title']!,
                  style: TextStyle(
                      color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(joke['description']!)
              ],
            ),
          ),
          IconButton(
            onPressed: () => onFavoriteSelected(joke['id']!),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
