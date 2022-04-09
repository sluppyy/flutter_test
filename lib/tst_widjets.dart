import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TstStls extends StatefulWidget {
  const TstStls({Key? key}) : super(key: key);

  @override
  State<TstStls> createState() => _TstStlsState();
}

class _TstStlsState extends State<TstStls> {
  List<int> data = List<int>.generate(10, returnItself);

  Widget _buildItemList(BuildContext context, int index) {
    if (index == data.length) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
        padding: const EdgeInsets.all(16),
        child:  Column(
            children: [
              Container(
                  color: Colors.redAccent,
                  width: 200,
                  height: 200,
                  child: Center(child: Text(data[index].toString(), style: const TextStyle(fontSize: 20))
            )
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
                onItemFocus: print,
                itemSize: 200 + 16*2,
                itemBuilder: _buildItemList,
                itemCount: data.length);
  }
}

T returnItself<T>(T value) => value;