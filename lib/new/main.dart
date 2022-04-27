import 'package:flutter/material.dart';
import 'package:startup_namer/legacy/AuthPage.dart';
import 'package:startup_namer/legacy/VideoPlayer.dart';
import 'package:startup_namer/new/data/AuthProblem.dart';
import 'package:startup_namer/new/data/screens/GlobalScreen.dart';
import 'package:startup_namer/new/extensions/converters/NewUserToOld.dart';
import 'package:startup_namer/new/extensions/converters/NewVideoToOld.dart';
import 'package:startup_namer/new/repository/ProfileRepository.dart';
import 'package:startup_namer/new/repository/VideosRepository.dart';
import 'package:startup_namer/new/view/screens/MainScreen.dart';
import 'package:startup_namer/new/view/theme/BasicTheme.dart';
import 'package:startup_namer/new/view/widgets/BluredBackground.dart';

import 'controller/ProfileController.dart';
import 'controller/VideosController.dart';
import 'data/Video.dart';

void main() {
  final profileRepository = ProfileRepository();
  final profileController = ProfileController(null, profileRepository);

  final videosRepository = VideosRepository(profileController);
  final videosController = VideosController(videosRepository);

  runApp(App(
      videosController: videosController,
      profileController: profileController
  ));
}

class App extends StatefulWidget {
  final ProfileController profileController;
  final VideosController videosController;

  const App({Key? key,
    required this.profileController,
    required this.videosController
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Video? _video;
  GlobalScreen _currentScreen = GlobalScreen.main;

  @override
  void initState() {
    super.initState();
    widget.videosController.selectedVideo.addListener(_onSelectVideo);
    widget.profileController.authProblems.addListener(_onAuthProblem);
  }

  @override
  void dispose() {
    widget.videosController.selectedVideo.removeListener(_onSelectVideo);
    widget.profileController.authProblems.removeListener(_onAuthProblem);
    super.dispose();
  }

  void _onAuthProblem() {
    if (widget.profileController.authProblems.value == AuthProblem.needAuth) {
      setState((){_currentScreen = GlobalScreen.auth;});
    }
  }


  void _onSelectVideo() {
    setState(() {
      _video = widget.videosController.selectedVideo.video;
      _currentScreen = _video == null
          ? GlobalScreen.main
          : GlobalScreen.videoPlayer;
    });
  }

  MaterialPage _buildVideoPlayer() => MaterialPage(child: PlayerMusic(
    video: (_video ?? Video.empty()).toVideo(),
    onLikeMusic: widget.videosController.likeOld,
    onPop: widget.videosController.unselectVideo,
  ));
  MaterialPage _buildMainScreen () => MaterialPage(child: MainScreen(
      profileController: widget.profileController,
      videosController: widget.videosController
  ));
  MaterialPage _buildAuthScreen () => MaterialPage(child: AuthPage(
    onNewUser: widget.profileController.saveOldUser,
    onLogIn: widget.profileController.logIn,
    onSignUp: widget.profileController.signUp,
  ));
  
  bool _onPop(Route route, dynamic result) => route.didPop(result);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: basicTheme,
        home: Stack(children: [
          const BlurBackground(),
          Navigator(
              onPopPage: _onPop,
              pages: [
                _buildMainScreen(),
                if (_currentScreen != GlobalScreen.main) {
                  GlobalScreen.videoPlayer: _buildVideoPlayer,
                  GlobalScreen.auth:        _buildAuthScreen
                }[_currentScreen]!()
              ]
          )
        ])
    );
  }
}