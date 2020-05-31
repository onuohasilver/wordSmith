import 'package:flutter/material.dart';

final kLevelSelectContainerDecoration =BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.yellowAccent[100],
              Colors.lightBlueAccent[100],
            ], transform: GradientRotation(24)),
          );

final kTitleSelectText =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 35);

final kLevelOneContainerDecoration= BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.2, 1],
    colors: [Colors.lightBlue[900], Colors.lightGreen[700]],
  ),
);

final kGreenPageDecoration=BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[700], Colors.green[400]],
              ),
            );
final kPurpleScreenDecoration=BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700], Colors.purple[400]],
          ),
        );


final kTextShadow=[Shadow(blurRadius: 3, color: Colors.grey)];