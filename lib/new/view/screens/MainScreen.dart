import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:startup_namer/legacy/MuscicPage.dart';
import 'package:startup_namer/new/controller/ProfileController.dart';
import 'package:startup_namer/new/controller/VideosController.dart';
import 'package:startup_namer/new/data/User.dart';
import 'package:startup_namer/new/extensions/converters/NewVideoToOld.dart';
import 'package:startup_namer/new/view/screens/HomeScreen.dart';
import 'package:startup_namer/new/view/widgets/BottomNavBar.dart';
import 'package:startup_namer/new/extensions/converters/NewUserToOld.dart';

import '../../../legacy/ProfileScreen.dart';
import '../../data/Video.dart';
import '../../data/screens/Screen.dart';

class MainScreen extends StatefulWidget {
  final ProfileController profileController;
  final VideosController videosController;

  const MainScreen({
    Key? key,
    required this.profileController,
    required this.videosController
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentScreen = Screen.home;
  User? _user;
  List<Video> _allVideos = [];
  List<Video> _likedVideos = [];
  
  void _onSelect(int index) {
    setState(() {
      switch (index) {
        case 0: _currentScreen = Screen.home;        break;

        case 1: {widget.videosController.downloadLikedVideos();
                _currentScreen = Screen.likedVideos; break;}

        case 2: {widget.videosController.downloadVideos();
                _currentScreen = Screen.allVideos;   break;}

        case 3: {widget.profileController.updateUser();
                _currentScreen = Screen.profile;     break;}
      }
    });
  }

  int _currentIndex() {
    switch (_currentScreen) {
      case Screen.home:        return 0;
      case Screen.likedVideos: return 1;
      case Screen.allVideos:   return 2;
      case Screen.profile:     return 3;
    }
  }

  void _onUpdateAllVideos() {
    setState(() {
      _allVideos = widget.videosController.allVideos.videos;
    });
  }

  void _onUpdateLiked() {
    setState(() {
      _likedVideos = widget.videosController.likedVideos.videos;
    });
  }

  void _onNewUser() {
    setState(() {
      _user = widget.profileController.user;
    });
  }

  @override
  void initState() {
    super.initState();

    widget.profileController.addListener(_onNewUser);
    widget.videosController.allVideos.addListener(_onUpdateAllVideos);
    widget.videosController.likedVideos.addListener(_onUpdateLiked);
  }

  @override
  void dispose() {
    widget.profileController.removeListener(_onNewUser);
    widget.videosController.allVideos.removeListener(_onUpdateAllVideos);
    widget.videosController.likedVideos.removeListener(_onUpdateLiked);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0x00ffffff),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: _currentIndex(), onSelect: _onSelect),
      body: {
        Screen.home:        () => HomeScreen(controller: widget.videosController),

        Screen.likedVideos: () => MusicScreen(
            allMusic: _likedVideos.toVideos(),
            onMusicClick: widget.videosController.selectOldVideo,
            title: "Liked"),

        Screen.allVideos:   () => MusicScreen(
            allMusic: _allVideos.toVideos(),
            onMusicClick: widget.videosController.selectOldVideo,
            title: "Videos"),

        Screen.profile:     () => _user != null
            ? ProfileScreen(user: _user!.toUser(), onSaveUser: widget.profileController.saveOldUser)
            : const Center(child: CircularProgressIndicator(color: Colors.white))
      }[_currentScreen]!()
  );
}