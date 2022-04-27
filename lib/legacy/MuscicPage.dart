import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'MusicChoise.dart';

class MusicScreen extends StatefulWidget {
  final List<Video> allMusic;
  final void Function(Video) onMusicClick;
  final String title;

  const MusicScreen({Key? key,
    required this.allMusic,
    required this.onMusicClick,
    required this.title
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List<Video> searchedMusic = [];
  String filter = "";

  @override
  void initState() {
    super.initState();
    searchedMusic = widget.allMusic;
  }

  void _filterMusic(String filter) {
    setState(() {
      searchedMusic = widget.allMusic.where(isMusicInFilter).toList();
      this.filter = filter;
    });
  }

  bool isMusicInFilter(Video music) => music.title.toLowerCase().contains(filter.toLowerCase()) || music.author.toLowerCase().contains(filter.toLowerCase());

  Widget _stringWithFilter(String string, double fontSize, Color color, String filter) {
    List<Widget> chars = [];

    int fstInex = string.toLowerCase().indexOf(filter.toLowerCase());

    if (filter.isEmpty || fstInex == -1) {
      for (var char in toList(string)) {
        chars.add(Text(char, style: TextStyle(fontSize: fontSize, color: color)));
      }

      return Row(children: chars);
    }

    for (var char in toList(string).getRange(0, fstInex)) {
      chars.add(Text(char, style: TextStyle(fontSize: fontSize, color: color)));
    }

    for (var char in toList(string).getRange(fstInex, fstInex+filter.length)) {
      chars.add(Text(char, style: TextStyle(fontSize: fontSize, color: Colors.lightGreenAccent)));
    }

    for (var char in toList(string).getRange(fstInex+filter.length, string.length)) {
      chars.add(Text(char, style: TextStyle(fontSize: fontSize, color: color)));
    }

    return Row(children: chars);
  }

  Widget _musicBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){widget.onMusicClick(searchedMusic[index]);},
      child: Row(
          children: [
            Padding(padding: const EdgeInsets.all(12),
                child: SizedBox(width: 60, height: 60,
                    child: ClipRRect(borderRadius: BorderRadius.circular(12),
                        child: SizedBox(child: Image.network(widget.allMusic[index].preview_src, fit: BoxFit.cover),height: 60)))),

            Expanded(child: SizedBox(
                height: 60,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(Radius.circular(12))),
                            child: Row(children: [Padding(padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _stringWithFilter(searchedMusic[index].title, 18, Colors.white, filter),
                                      _stringWithFilter(searchedMusic[index].author, 16, Colors.white38, filter)
                                    ])
                            )])
                        ))))),

            const Padding(padding: EdgeInsets.all(12), child: Icon(Icons.view_headline_sharp, size: 30, color: Colors.white))
          ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    _filterMusic(filter);

    return Scaffold(
        backgroundColor: const Color(0x00ffffff),
        appBar: AppBar(centerTitle: true, elevation: 0, title: Text(widget.title)),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(child: SearchBar(onSearch: _filterMusic, filter: filter))
          ),

          Expanded(child: ListView.builder(
              itemCount: searchedMusic.length,
              itemBuilder: _musicBuilder))
        ])
    );
  }
}

class SearchBar extends StatelessWidget {
  final void Function(String) onSearch;
  final controller = TextEditingController();
  final filter;

  SearchBar({Key? key, required this.onSearch, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = filter;

    controller.addListener(() {
      if (controller.text.isEmpty) {onSearch("");}
    });

    return Row(children: [
      Expanded(child: SizedBox(height: 50, child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
        ),
      ))),

      IconButton(onPressed: (){
        onSearch(controller.text);
      }, icon: const Icon(Icons.search, color: Colors.white))
    ]);
  }

}

List<Video> fakeMusic() {
  final result = [  Video("Name", "Author", src: "", id: -1)];

  for (int x = 0;x<30;x++) {
    result.add(Video(fakePair(), fakePair(), src: "", id: x));
  }

  return result;
}

String fakePair() => WordPair.random().asPascalCase + " " + WordPair.random().asPascalCase;

List<String> toList(String string) {
  final List<String> result = [];

  for (int x=0;x<string.length;x++) {
    result.add(string[x]);
  }

  return result;
}