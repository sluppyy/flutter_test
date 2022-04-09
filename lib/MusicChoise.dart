import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class MusicChoice extends StatefulWidget {
  const MusicChoice({Key? key}) : super(key: key);

  @override
  State<MusicChoice> createState() => _MusicChoiceState();
}

class _MusicChoiceState extends State<MusicChoice> {
  List<Music> music = [
    Music("Club life", "Electronic"),
    Music("Club life", "Electronic"),
    Music("Club life", "Electronic"),
    Music("Club life", "Electronic"),
    Music("Club life", "Electronic"),
  ];

  int focused = 0;

  Widget _musicWidget(BuildContext context, int index) {
    return Padding(padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 240, height: 300,
          child: Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                      height: 300,
                      child: Image.asset("assets/danse.jpg", fit: BoxFit.cover)
                  )
              ),

              index == focused
                  ? Align(alignment: Alignment.bottomCenter,
                child: Padding(padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 90,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(14))),
                              child: Row(
                                  children: [
                                    Center(child: Padding(padding: const EdgeInsets.all(4),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                      Text(music[index].name, style: const TextStyle(fontSize: 20, color: Colors.white)),
                                      Text(music[index].author, style: const TextStyle(fontSize: 18, color: Colors.blueGrey))]))),

                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: gradientButton())))
                                  ]
                              ),
                            )
                        )
                    )
                  )
                )
              )
                  : Container()
            ]
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
        itemBuilder: _musicWidget,
        itemCount: music.length,
        itemSize: 240 + 16*2,
        onItemFocus: (i) {setState(() {
          focused = i;
        });}
    );
  }
}

class Music {
  final String name;
  final String author;
  final String image_src;

  Music(this.name, this.author, {this.image_src = ""});
}

Widget gradientButton() {
  return Container(
    decoration: const ShapeDecoration(
        gradient:  LinearGradient(colors: [Colors.blue, Colors.tealAccent]),
        shape: StadiumBorder()),
    child: IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {  },),
  );
}