import 'dart:math';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

/// Returns a random color grad
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
  filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
  child: Text('.'),
);
