import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';

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
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'W', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'O', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'R', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'D', active: true, mapNumber: null),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'C', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'R', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'A', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'F', active: true, mapNumber: null),
              ),
              AlphabetButton(
                alphabetDetail: AlphabetDetail(
                    alphabet: 'T', active: true, mapNumber: null),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
