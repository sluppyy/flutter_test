import 'package:flutter/material.dart';
import 'package:startup_namer/new/controller/VideosController.dart';
import 'package:startup_namer/new/view/widgets/HorizontalVideoList.dart';

import '../../../legacy/GenreChoise.dart';
import '../../../legacy/PageChoise.dart';
import '../../data/Video.dart';

class HomeScreen extends StatefulWidget {
  final VideosController controller;

  const HomeScreen({Key? key,
    required this.controller
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Video> _videos = [];

  @override
  void initState() {
    super.initState();
    _videos = widget.controller.allVideos.videos;

    widget.controller.allVideos.addListener(_setVideos);
  }

  @override
  void dispose() {
    widget.controller.allVideos.removeListener(_setVideos);

    super.dispose();
  }

  void _setVideos() => setState(() {
    _videos = widget.controller.allVideos.videos;
  });

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Column(
        children: [
          const SizedBox(height: 40),
          const SizedBox(child: PageChoice(), height: 70),
          Expanded(child: Center(child: SizedBox(child: HorizontalVideoList(
            onSelectVideo: widget.controller.selectVideo,
            videos: _videos
          ), height: 300))),
          const SizedBox(child: Text("Genre", style: TextStyle(fontSize: 30, color: Colors.white)), height: 40),
          const SizedBox(child: GenreChoice(), height: 120 + 16*2)
        ],
      ),
    ],
  );
}