import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PageChoice extends StatefulWidget {
  const PageChoice({Key? key}) : super(key: key);
  @override
  State<PageChoice> createState() => _PageChoiceState();
}

class _PageChoiceState extends State<PageChoice> {
  List<String> data = ["Beauty", "Music", "Design"];

  int focused = 0;

  Widget _pageWidget(BuildContext context, int index) {
    bool isF = focused == index;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(width: 140, child: Center(child: Text(data[index], style: TextStyle(
            fontSize: isF ? 35 : 25,
            color: isF ? Colors.white : Colors.blueGrey))),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
        itemBuilder: _pageWidget,
        itemCount: data.length,
        itemSize: 140 + 16*2,
        onItemFocus: (i){setState(() {
          focused = i;
        });});
  }
}