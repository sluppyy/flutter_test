import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:startup_namer/legacy/AuthPage.dart';
import 'package:startup_namer/legacy/MuscicPage.dart';
import 'package:startup_namer/legacy/MusicChoise.dart';
import 'package:startup_namer/legacy/PageChoise.dart';
import 'package:startup_namer/legacy/ProfileScreen.dart';
import 'package:startup_namer/legacy/VideoPlayer.dart';
import 'package:startup_namer/legacy/serverVideo/VideoData.dart';
import 'package:startup_namer/legacy/serverVideo/likedServerVideo/LikedServerVideo.dart';
import 'package:startup_namer/legacy/serverVideo/likedServerVideo/ListLikedVideos.dart';
import 'package:startup_namer/legacy/serverVideo/serverVideo.dart';
import 'package:startup_namer/legacy/User.dart';


import '../new/data/GlobalVariables.dart';
import 'GenreChoise.dart';

void main() {
  runApp(const MyApp());
}

enum Screen {
  HOME,
  ALL_MUSIC,
  LIKED_MUSIC,
  AUTHORIZATION,
  PROFILE
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMusicDownloaded = false;

  Screen currentScreen = Screen.HOME;

  User? user;

  List<Video> videos = [];
  Video? selectedMusic;
  List<Video> liked_videos = [];

  void _navigate(index) {
    setState(() {
      switch (index) {
        case 0: currentScreen = Screen.HOME;        break;
        case 1: {
          currentScreen = Screen.LIKED_MUSIC;
          downloadLikedMusic();
          break;
        }
        case 2: {
          currentScreen = Screen.ALL_MUSIC;
          downloadMusic();
          break;
        }
        case 3: currentScreen = Screen.PROFILE;     break;
      }
    });
  }

  void onLikeMusic(Video video) async {
    if (user == null) return;

    final likeOrDis = video.like().is_liked
        ? "like"
        : "dislike";

    final like_result = await get(
        Uri.parse(server + "/api/videos/$likeOrDis/${video.id}"),
        headers: authHeader(bearer: user!.bearer)
    );

    final likedVideosResult = await get(
      Uri.parse(server + "/api/videos/liked"),
      headers: authHeader(bearer: user!.bearer)
    );

    setState(() {
      //videos = mapList(list: videos, mapper: (Video mm) {

      //   if (video.id == mm.id) {
      //     return mm.like();
      //   } else {
      //     return mm;
      //   }
      // });
      // liked_videos = videos.where((element) => element.is_liked).toList();

      selectedMusic = video.like();

      liked_videos = mapList(
          list: ListLikedVideos.fromJson(jsonDecode(likedVideosResult.body)).data,
          mapper: (LikedServerVideo sv) => Video(
              sv.title,
              "author",
              src: server + sv.src.url,
              preview_src: server + sv.preview.url,
            id: sv.id,
            is_liked: true
          )
      );
    });
  }

  void onClickOnMusic(Video music) {
    setState(() {
      selectedMusic = music;
    });
  }

  @override void initState() {
    super.initState();
    liked_videos = videos.where((element) => element.is_liked).toList();
  }

  void downloadMusic() async {
    if (isMusicDownloaded || user == null) return;

    final result = await get(
        Uri.parse("$server/api/videos?populate=*"),
        headers: authHeader(bearer: user!.bearer)
    );

    if (result.statusCode == 200) {
      setState(() {
        videos = mapList(
            list: ServerVideo.fromJson(jsonDecode(result.body)).data,
            mapper: (VideoData video) =>  Video(
                video.attributes.title,
                "author",
                src: server + video.attributes.src.data.attributes.url,
                preview_src: server + video.attributes.preview.data.attributes.url,
                is_liked: video.attributes.is_liked,
                id: video.id
            ),
        );
      });
      //isMusicDownloaded = true;
    }
  }

  void downloadLikedMusic() async {
    if (user == null) return;

    final likedVideosResult = await get(
        Uri.parse(server + "/api/videos/liked"),
        headers: authHeader(bearer: user!.bearer)
    );

    setState(() {
      liked_videos = mapList(
          list: ListLikedVideos.fromJson(jsonDecode(likedVideosResult.body)).data,
          mapper: (LikedServerVideo sv)=> Video(
              sv.title,
              "author",
              src: server + sv.src.url,
              preview_src: server + sv.preview.url,
              id: sv.id,
              is_liked: true
          )
      );
    });
  }

  void _saveUser(User user) async {
    final response = await put(
        Uri.parse("$server/api/users/${user.id}"),
        headers: {
          "Authorization": "Bearer ${user.bearer}"
        },
        body: {
          "username": user.name,
          "email": user.email,
          "phone": user.phoneNumber,
          "about": user.about
        }
    );

    if (response.statusCode == 200) {
      setState(() {this.user = user;});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error")));
    }
  }

  void _logInUser(User user) async {

    setState(() {
      this.user = user;
    });
  }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0x00ffffff),
                foregroundColor: Colors.white
            )
        ),
        home: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/smoke.jpg"),
                        fit: BoxFit.cover
                    )
                )
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black26.withOpacity(0.6)),
                )
            ),
            //ProfileScreen(user: user, onSaveUser: (user){setState(() {
            //  this.user = user;
            //});})
            Navigator(
              pages: [
                MaterialPage(child: MainScreen(onNavigate: _navigate, onSelectMusic: onClickOnMusic)),

                if (currentScreen == Screen.PROFILE) MaterialPage(
                    child: user == null
                        ? AuthPage(
                      onNewUser: _logInUser,
                      onSignUp: ({required String email, required String password, required String username}) {  },
                      onLogIn: ({required String password, required String username}) {  },)
                        : ProfileScreen(user: user!, onSaveUser: _saveUser,)
                ),
                if (currentScreen == Screen.ALL_MUSIC)   MaterialPage(child: MusicScreen(allMusic: videos, onMusicClick: onClickOnMusic, title: "Videos")),
                if (currentScreen == Screen.LIKED_MUSIC) MaterialPage(child: MusicScreen(allMusic: liked_videos, onMusicClick: onClickOnMusic, title: "Favorite")),

                if (selectedMusic != null)  MaterialPage(child: PlayerMusic(video: selectedMusic!, onLikeMusic: onLikeMusic, onPop: () {  },))
              ],
              onPopPage: (route,result){
                selectedMusic = null;
                return route.didPop(result);
              },
            )
          ],
        ),
        debugShowCheckedModeBanner: false,
      );
    }
  }

class MainScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  final void Function(Video) onSelectMusic;

  const MainScreen({Key? key,
    required this.onNavigate,
    required this.onSelectMusic
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    widget.onNavigate(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x00ffffff),
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: const Color(0x00ffffff),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Podcasts"),
              Icon(Icons.mic)
            ],
          ),
          leading: IconButton(icon: const Icon(Icons.add_alert), onPressed: () {  }),
          actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {  })],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0x00ffffff),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color(0x00ffffff),
            type: BottomNavigationBarType.shifting,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(activeIcon: Icon(Icons.home), icon: Icon(Icons.home, color: Colors.grey), label: ""),
              BottomNavigationBarItem(activeIcon: Icon(Icons.favorite), icon: Icon(Icons.favorite, color: Colors.grey), label: ""),
              BottomNavigationBarItem(activeIcon: Icon(Icons.album), icon: Icon(Icons.album, color: Colors.grey), label: ""),
              BottomNavigationBarItem(activeIcon: Icon(Icons.person), icon: Icon(Icons.person, color: Colors.grey), label: "")
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(child: PageChoice(), height: 70),
                Expanded(child: Center(child: SizedBox(child: MusicChoice(onSelectMusic: widget.onSelectMusic,), height: 300))),
                const SizedBox(child: Text("Genre", style: TextStyle(fontSize: 30, color: Colors.white)), height: 40),
                const SizedBox(child: GenreChoice(), height: 120 + 16*2)
              ],
            ),
          ],
        )
    );
  }
}

List<R> mapList<T, R>({required List<T> list, required R Function(T) mapper}) {
  final List<R> result = [];

  for (T value in list) {
    result.add(mapper(value));
  }

  return result;
}

