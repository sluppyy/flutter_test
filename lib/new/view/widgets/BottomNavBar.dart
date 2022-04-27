import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onSelect;

  const CustomBottomNavBar({Key? key,
    required this.currentIndex,
    required this.onSelect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(canvasColor: const Color(0x00ffffff)),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: const Color(0x00ffffff),
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(activeIcon: Icon(Icons.home),        icon: Icon(Icons.home,        color: Colors.grey), label: ""),
          BottomNavigationBarItem(activeIcon: Icon(Icons.favorite),    icon: Icon(Icons.favorite,    color: Colors.grey), label: ""),
          BottomNavigationBarItem(activeIcon: Icon(Icons.web_rounded), icon: Icon(Icons.web_rounded, color: Colors.grey), label: ""),
          BottomNavigationBarItem(activeIcon: Icon(Icons.person),      icon: Icon(Icons.person,      color: Colors.grey), label: "")
        ],
        currentIndex: currentIndex,
        onTap: onSelect,
      )
  );
}