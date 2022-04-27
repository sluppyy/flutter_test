import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final List<Color> colors;

  const GradientWidget({Key? key, required this.child, this.colors = projectGradien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
            gradient:  LinearGradient(colors: colors),
            shape: const StadiumBorder()),
        child: child
    );
  }
}

const List<Color> projectGradien = [Colors.blue, Colors.tealAccent];