import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  final AssetImage image;
  final double blur;

  const BlurBackground({Key? key,
    this.image = const AssetImage("assets/smoke.jpg"),
    this.blur = 10
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(children: [
    Container(decoration: BoxDecoration(
      image: DecorationImage(
          image: image,
          fit: BoxFit.cover
      )
    )),

    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6))
      )
    )
  ]);
}