import 'package:flutter/material.dart';
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
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            blurBox,
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width * .56,
                  height: height * .25,
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
                height: height * .15,
                width: width * .7,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        ImageAssets.star,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        ImageAssets.star,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(ImageAssets.star),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
