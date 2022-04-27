import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PageChoice extends StatefulWidget {
  const PageChoice({Key? key}) : super(key: key);
  @override
  State<PageChoice> createState() => _PageChoiceState();
}

class _PageChoiceState extends State<PageChoice> {
  List<String> data = ["Beauty", "Video", "Design"];

  int focused = 0;

  Widget _pageWidget(BuildContext context, int index) {
    bool isF = focused == index;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(width: 120,
          child: isF
              ? SizedBox(height: 100, child: Align(alignment: Alignment.topCenter, child: Text(data[index], style: const TextStyle(
              fontSize: 35,
              color: Colors.white))))
              : Center(child: Text(data[index], style: const TextStyle(
            fontSize: 25,
            color: Colors.grey)))
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
        itemBuilder: _pageWidget,
        itemCount: data.length,
        itemSize: 120 + 16*2,
        onItemFocus: (i){setState(() {
          focused = i;
        });});
  }
}