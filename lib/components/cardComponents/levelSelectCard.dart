import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/sqlCache.dart';

class LevelCard extends StatelessWidget {
  ///Text displayed on Card Body [label] must be a non-null value
  final String label;

  ///Named route to be navigated to onTap [routeName] must not be a non-null value
  final String routeName;

  ///MediaQuery height data[height] must be specified.
  final double height;

  ///MediaQuery height data[width] must be specified.
  final double width;

  /// a controller that needs to be disposed on page routing
  final AnimationController controller;

  /// Returns a flat Tap-aware Card Widget with [assets/labelHanger.png] as a background
  ///  that takes two
  /// arguments the card [label] that will be displayed on the
  /// card body and the [routeName] which is a specified route
  /// where the card navigates to onTap both values are String values.

  /// ```dart
  /// LevelCard('Card Label','Home Screen');
  /// ```
  LevelCard({
    this.label,
    @required this.routeName,
    @required this.height,
    @required this.width,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    GameSound gameSound = GameSound();
    SqlCache dbCache = Provider.of<SqlCache>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(80.0, 13.0, 88.0, 3.0),
      child: Stack(
        children: [
          Container(child: Image.asset('assets/labelHanger.png')),
          Positioned.fill(
            bottom: height * .01,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -pi / 33,
                child: Container(
                  height: height * .09,
                  width: width * .58,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      splashColor: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            label,
                            style: GoogleFonts.poppins(
                                fontSize: height * .03,
                                color: Colors.white54,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        dbCache.cacheDBresponse();
                        Navigator.pushNamed((context), routeName);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
