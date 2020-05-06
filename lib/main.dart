import 'package:flutter/material.dart';
import 'package:wordsmith/screens/levels/level_one_entry.dart';
import 'package:wordsmith/screens/loadingScreen.dart';
import 'package:wordsmith/screens/LevelSelectScreen.dart';

void main(){
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'LoadingScreen',
      routes: {
        'LevelSelect':(context)=>LevelSelectScreen(),
        'LoadingScreen':(context)=>LoadingScreen(),
        'LevelOneEntryScreen':(context)=>LevelOneEntry()

      },
    );
  }
}