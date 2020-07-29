import 'dart:math';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

/// Returns a random color gradient pair
/// as a BoxDecoration property
class GradientSetter {
  int random = Random().nextInt(gradientList.length);

  ///returns a random gradient from the pre-specified gradientList
  BoxDecoration get randomPair {
    print(random);
    return BoxDecoration(
      gradient: gradientList[random],
    );
  }
}

const List<LinearGradient> gradientList = [
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffc94b4b),
      Color(0xff4c134f),
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffad5389),
      Color(0xff3c1053),
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff134e5e),
      Color(0xff71b280),
    ],
  ),
];

var kLevelSelectContainerDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [
    Color(0xffc94b4b),
    Color(0xff4c134f),
  ]),
);

final kTitleSelectText = GoogleFonts.creepster(
    color: Colors.brown[900],
    fontWeight: FontWeight.w800,
    fontSize: 70,
    shadows: [
      Shadow(offset: Offset(-1, 1), color: Colors.white),
      Shadow(offset: Offset(0, 1), color: Colors.white),
      Shadow(offset: Offset(1, -1), color: Colors.white),
      Shadow(offset: Offset(1, 0), color: Colors.white),
    ]);

final kLevelOneContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.2, 1],
    colors: [Colors.lightBlue[900], Colors.lightGreen[700]],
  ),
);

final kGreenPageDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue[700], Colors.green[400]],
  ),
);
final kPurpleScreenDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue[700], Colors.purple[400]],
  ),
);

final kTextShadow = [Shadow(blurRadius: 3, color: Colors.grey)];
///blurs out the background image behind it.
/// 
/// child is a simple [Text] widget with a ['.'] as content.
final BackdropFilter blurBox = BackdropFilter(
  filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
  child: Text('.'),
);

//blurs out the background image behind it.
/// 
/// child is a simple [Text] widget with a ['.'] as content.
final BackdropFilter blurBoxLower = BackdropFilter(
  filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
  child: Text('.'),
);
