import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.black
        )
      ),
      home: const RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        final tiles = _saved.map((pair) {
          return ListTile(title: Text(pair.asSnakeCase, style: _biggerFont));
        });

        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(tiles: tiles, context: context).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(title: const Text("Saved Suggestions"),),
          body: ListView(children: divided,),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("app bar"),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            )
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, i) {
              if (i.isOdd) return const Divider();

              final index = i ~/ 2;
              if (index >= _suggestions.length) {
                  _suggestions.addAll(generateWordPairs().take(10));}

              final pair = _suggestions[index];
              final alreadySaved = _saved.contains(pair);
              return ListTile(
                title: Text(pair.asSnakeCase, style: _biggerFont,),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? "Remove from saved" : "Save",
                ),
                onTap: () {
                  setState(() {
                    alreadySaved ? _saved.remove(pair) : _saved.add(pair);
                  });
                },
              );
            }
        )
    );
  }
}