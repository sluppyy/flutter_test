import 'package:flutter/material.dart';

Widget GradientButton({void Function()? onClick, required Widget icon}) => Container(
  decoration: const ShapeDecoration(
      gradient:  LinearGradient(colors: [Colors.blue, Colors.tealAccent]),
      shape: StadiumBorder()),
  child: IconButton(icon: icon, onPressed: () { onClick!(); },),
);