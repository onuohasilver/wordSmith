import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';

class WordCraftLogo extends StatelessWidget {
  ///Creates the App Logo Widget
  const WordCraftLogo({
    Key key,
    @required this.width,
    @required this.height,
    this.animation,
  }) : super(key: key);

  ///MediaQuery request on the width of the current context
  final double width;

  ///MediaQuery request on the height of the current context
  final double height;

  ///Animation double for the transformation of the text
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
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
                transform: Matrix4.rotationX(pi / 5 * (animation?.value ?? 0)),
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
      ),
    );
  }
}
