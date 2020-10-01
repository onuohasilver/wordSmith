import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/components/inputComponents/buttons/slimButtons.dart';
import 'package:wordsmith/core/imageAssets.dart';
import 'package:wordsmith/core/utilities/constants.dart';

class LevelComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 500,
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height * .4,
        child: Stack(
          children: <Widget>[
            blurBox,
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width * .56,
                  height: height * .23,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow[600], width: 5),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.lightBrownBG),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height * .17,
                width: width * .6,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Star(),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform.rotate(angle: pi / 2, child: Star()),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Transform.rotate(angle: -pi / 2, child: Star()),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 30,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Level Complete!',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '65',
                      style: GoogleFonts.aclonica(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SlimButton(
                      label: 'Continue',
                      onTap: () {},
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SlimButton(
                      label: 'Back',
                      onTap: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Star extends StatelessWidget {
  const Star({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Image.asset(
        ImageAssets.star,
      ),
    );
  }
}



