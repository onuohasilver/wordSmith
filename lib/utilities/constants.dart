import 'dart:math';

import 'package:flutter/material.dart';

/// Returns a random color gradient pair
/// as a BoxDecoration property
///

class GradientSetter {
  int random = Random().nextInt(gradientList.length);

  BoxDecoration get randomPair {
    print(random);
    return BoxDecoration(
      gradient: gradientList[random],
     
    );
  }
}

const List<LinearGradient> gradientList = [
  LinearGradient(
    colors: [Color(0xff000e54), Color(0xff2a4299)],
     stops: [0.2, 1],
  ),
  LinearGradient(
    colors: [
      Color(0xffc94b4b),
      Color(0xff4c134f),
    ],
  ),
  LinearGradient(
    colors: [
      Color(0xffad5389),
      Color(0xff3c1053),
    ],
  ),
  LinearGradient(
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

final kTitleSelectText =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 35);

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
