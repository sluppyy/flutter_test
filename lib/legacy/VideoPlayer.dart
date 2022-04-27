import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:startup_namer/legacy/GradientWidget.dart';
import 'package:video_player/video_player.dart';

import 'MusicChoise.dart';

class PlayerMusic extends StatefulWidget {
  final Video video;
  final void Function(Video) onLikeMusic;
  final void Function() onPop;

  const PlayerMusic({Key? key,
    required this.video,
    required this.onLikeMusic,
    required this.onPop
  }) : super(key: key);

  @override
  State<PlayerMusic> createState() => _PlayerMusicState();
}

class _PlayerMusicState extends State<PlayerMusic> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  double currentPercentOfPlaying = 0;
  bool isMusicPlaying = false;
  
  void _setMusicPlaying() {
    setState(() {
      isMusicPlaying = !isMusicPlaying;

      if (isMusicPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.video.src);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      setState(() {
        currentPercentOfPlaying = _controller.value.position.inSeconds / _controller.value.duration.inSeconds;
        if (!(currentPercentOfPlaying >= 0 && currentPercentOfPlaying <= 1)) {
          currentPercentOfPlaying = 0;
        }
        isMusicPlaying = _controller.value.isPlaying;
      });
    });
  }

  void setPosOfPlay(double pos) {
    _controller.seekTo(Duration(
        seconds: (_controller.value.duration.inSeconds * pos).toInt()
    ));
  }

  @override void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00ffffff),
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.fromLTRB(18, 0, 0, 0), child: IconButton(onPressed: widget.onPop, icon: const Icon(Icons.arrow_back))),
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("Playing now ", style: TextStyle(color: Colors.white70)), Icon(Icons.volume_up_sharp, color: Colors.white)]
        ),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.fromLTRB(0, 0, 18, 0), child: IconButton(onPressed: (){}, icon: const Icon(Icons.menu)))]),
      body: Column(children: [
        Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(40, 30, 40, 0), child: Center(child: SizedBox(height: 400,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) { 
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
            )))),
        SizedBox(height: 400, child: Padding(padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
            child: MediaPlayer(
                music: widget.video,
                isMusicPlaying: isMusicPlaying,
                onChangePlaying: _setMusicPlaying,
                onChangeDivider: setPosOfPlay,
                currentPercentOfPlaying: currentPercentOfPlaying,
                onLike: widget.onLikeMusic,
            )
        ))
      ])
    );
  }
}

class BigImage extends StatelessWidget {
  final String src;
  final double height;

  const BigImage({Key? key, required this.src, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(src, fit: BoxFit.cover, height: height)
      );
  }
}

class MediaPlayer extends StatelessWidget {
  final double                currentPercentOfPlaying;
  final Video                 music;
  final bool                  isMusicPlaying;
  final void Function()       onChangePlaying;
  final void Function(double) onChangeDivider;
  final void Function(Video)  onLike;

  const MediaPlayer({Key? key,
    required this.music,
    required this.isMusicPlaying,
    required this.onChangePlaying,
    required this.currentPercentOfPlaying,
    required this.onChangeDivider,
    required this.onLike
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(currentPercentOfPlaying);

    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
        child: ShaderMask(
            shaderCallback: (bounds) {
              return const RadialGradient(
                  colors: projectGradien,
                  center: Alignment.topLeft,
                  radius: 0.4,
                  tileMode: TileMode.mirror
              ).createShader(bounds);
            },
            child: Slider(
                value: currentPercentOfPlaying,
                onChanged: onChangeDivider
            )
        ),
      ),
      Row(children: [
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(music.title, style: const TextStyle(color: Colors.white, fontSize: 40), overflow: TextOverflow.ellipsis)
            )
        ),
        GestureDetector(
            onTap: (){onLike(music);},
            child: GradientIcon(
                icon: music.is_liked ? Icons.favorite : Icons.favorite_border_rounded,
                size: 40,
                gradient: const LinearGradient(colors: projectGradien)
            )
        )
      ]),
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
              child: Text(music.author, style: const TextStyle(color: Colors.white38, fontSize: 20))
          )
      ),
      Expanded(child: MediaController(isMusicPlaying: isMusicPlaying, onChangePlaying: onChangePlaying))
    ]);
  }
}

class MediaController extends StatelessWidget {
  const MediaController({Key? key, required this.isMusicPlaying, required this.onChangePlaying}) : super(key: key);
  
  final bool isMusicPlaying;
  final void Function() onChangePlaying;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.shuffle, color: Colors.white38)),
        Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white)))),

        SizedBox(width: 90, height: 90,
            child: GradientWidget(
            child: IconButton(
              iconSize: 36,
                onPressed: onChangePlaying,
                icon: Icon(isMusicPlaying ? Icons.pause : Icons.play_arrow, color: Colors.black)
            ),
            colors: projectGradien
        )
        ),

        Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)))),
        IconButton(onPressed: (){}, icon: const Icon(Icons.repeat, color: Colors.white38)),
      ]
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    required this.icon,
    required this.size,
    required this.gradient,
    Key? key
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}