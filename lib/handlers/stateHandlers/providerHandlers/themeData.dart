import 'package:flutter/material.dart';

class AppThemeData extends ChangeNotifier {
  BoxDecoration background = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/wooden-wall.jpg'), fit: BoxFit.cover));
}
