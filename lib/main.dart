import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:startup_namer/MusicChoise.dart';
import 'package:startup_namer/PageChoise.dart';

import 'GenreChoise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.black
        )
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
          ],
          selectedItemColor: Colors.redAccent,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
      ),),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/smoke.jpg"),
                  fit: BoxFit.cover
              )
            ),
          ),
          Column(
            children: const [
              SizedBox(child: PageChoice(), height: 70),
              Expanded(child: Center(child: SizedBox(child: MusicChoice(), height: 300))),
              SizedBox(child: Text("Genre", style: TextStyle(fontSize: 30, color: Colors.white)), height: 50),
              SizedBox(child: GenreChoice(), height: 120 + 16*2)
            ],
          ),
        ],
      )

    );
  }
}



