import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:startup_namer/new/data/Video.dart';

import 'GradientButon.dart';

class HorizontalVideoList extends StatefulWidget {
  final List<Video> videos;
  final void Function(Video) onSelectVideo;

  const HorizontalVideoList({Key? key,
    required this.videos,
    required this.onSelectVideo
  }) : super(key: key);

  @override
  State<HorizontalVideoList> createState() => _HorizontalVideoListState();
}

class _HorizontalVideoListState extends State<HorizontalVideoList> {
  int focused = 0;
  final _listController = ScrollController();

  Widget _buildVideoPreview(BuildContext context, int index) =>
      Padding(padding: const EdgeInsets.all(16),
        child: SizedBox(width: 240, height: 300,
          child: Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 300,
                child: Image.network(widget.videos[index].previewSrc, fit: BoxFit.cover))),

            index == focused
                ? Align(alignment: Alignment.bottomCenter,
                child: Padding(padding: const EdgeInsets.all(8),
                    child: _ButtonWithBluredBackgroun(
                        title: widget.videos[index].title,
                        description: widget.videos[index].author,
                        icon: const Icon(Icons.play_arrow),
                        onClick: ()=>widget.onSelectVideo(widget.videos[index]))))
                : Container()
          ])
        )
      );

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
        listController: _listController,
        itemBuilder: _buildVideoPreview,
        itemCount: widget.videos.length,
        itemSize: 240 + 16*2, //video preview * padding || 16 | 240 | 16
        onItemFocus: (newFocus){setState((){focused = newFocus;});}
    );
  }
}

Widget _ButtonWithBluredBackgroun({
  required String title,
  required String description,
  required Widget icon,
  required void Function() onClick
}) => SizedBox(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(padding: const EdgeInsets.all(4),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text(title, style: const TextStyle(fontSize: 20, color: Colors.white, overflow: TextOverflow.ellipsis)),
                          Text(description, style: const TextStyle(fontSize: 18, color: Colors.white70))]))),

                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: GradientButton(onClick: onClick, icon: icon))
                  ]
              ),
            )
        )
    )
);