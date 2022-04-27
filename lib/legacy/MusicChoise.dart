import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class MusicChoice extends StatefulWidget {
  final void Function(Video) onSelectMusic;

  const MusicChoice({Key? key, required this.onSelectMusic}) : super(key: key);

  @override
  State<MusicChoice> createState() => _MusicChoiceState();
}

class _MusicChoiceState extends State<MusicChoice> {
  List<Video> music = [
    Video("Club life", "Electronic", preview_src: "assets/club.jpg", src: "", id: -1),
    Video("Club life", "Electronic", preview_src: "assets/club.jpg", src: "", id: -1),
    Video("Club life", "Electronic", preview_src: "assets/club.jpg", src: "", id: -1),
    Video("Club life", "Electronic", preview_src: "assets/club.jpg", src: "", id: -1),
    Video("Club life", "Electronic", preview_src: "assets/club.jpg", src: "", id: -1),
  ];

  int focused = 0;

  Widget _musicWidget(BuildContext context, int index) {
    return Padding(padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 240, height: 300,
          child: Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                      height: 300,
                      child: Image.asset(music[index].preview_src, fit: BoxFit.cover)
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
                                            Text(music[index].title, style: const TextStyle(fontSize: 20, color: Colors.white)),
                                            Text(music[index].author, style: const TextStyle(fontSize: 18, color: Colors.white38))]))),

                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: gradientButton(
                                                      onClick: (){
                                                        widget.onSelectMusic(music[index]);
                                                      }
                                                  )
                                              )
                                          )
                                      )
                                    ]
                                ),
                              )
                          )
                      )
                  )))
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
        onItemFocus: (i) {setState(() {focused = i;});}
    );
  }
}

class Video {
  final int id;
  final String title;
  final String author;
  final String preview_src;
  final int duration_by_sec;
  final bool is_liked;
  final String src;

  Video(
      this.title,
      this.author, {
        this.preview_src = "assets/club.jpg",
        this.duration_by_sec = 60*3 + 26,
        this.is_liked = false,
        required this.src,
        required this.id
      });

  Video like() {
    return Video(
        title,
        author,
        preview_src: preview_src,
        duration_by_sec: duration_by_sec,
        is_liked: !is_liked,
        src: src,
        id: id);
  }
}

Widget gradientButton({void Function()?onClick}) {
  return Container(
    decoration: const ShapeDecoration(
        gradient:  LinearGradient(colors: [Colors.blue, Colors.tealAccent]),
        shape: StadiumBorder()),
    child: IconButton(icon: const Icon(Icons.play_arrow), onPressed: () { onClick!(); },),
  );
}

