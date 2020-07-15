import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';

class WordCraftLogo extends StatelessWidget {
  const WordCraftLogo({
    Key key,
    @required this.width,
    @required this.height,
    this.animation,
  }) : super(key: key);

  final double width;
  final double height;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * .3,
      child: Stack(
        children: [
          Center(
            child: Text(
              'WORD',
              textAlign: TextAlign.center,
              style: kTitleSelectText.copyWith(
                  color: Colors.brown[900], fontSize: height * .18),
            ),
          ),
          Positioned.fill(
            top: height * .18,
            child: Transform(
              transform: Matrix4.rotationX(pi/2 * (animation?.value??0)),
              child: Text(
                'CRAFT',
                textAlign: TextAlign.center,
                style: kTitleSelectText.copyWith(
                  color: Colors.green[900],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
