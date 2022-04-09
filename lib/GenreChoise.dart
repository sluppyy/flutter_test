import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

const danse_src = "assets/danse.jpg";

class Genre {
  final String image_src;
  final String name;
  Genre({this.image_src = "", this.name = ""});

  @override
  String toString() => "genre: $name";
}

class GenreChoice extends StatefulWidget {
  const GenreChoice({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenreChoice();
}

class _GenreChoice extends State<GenreChoice> {
  List<Genre> data = [
    Genre(image_src: danse_src, name: "Dance"),
    Genre(image_src: danse_src, name: "Techno"),
    Genre(image_src: danse_src, name: "Rock")
  ];

  Widget _genreWidgetBuilder(BuildContext context, int index) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
            width: 120, height: 120,
            child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const Image(image: AssetImage("assets/danse.jpg"))),

                  SizedBox(
                      height: 120,
                      child: Align(alignment: Alignment.bottomCenter,
                          child: Padding(padding: const EdgeInsets.all(12),
                              child: Text(
                                  data[index].name,
                                  style: const TextStyle(fontSize: 20, color: Colors.cyanAccent)
                              ))))
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
        itemBuilder: _genreWidgetBuilder,
        itemCount: data.length,
        itemSize: 120 + 16*2,
        onItemFocus: print);
  }
}