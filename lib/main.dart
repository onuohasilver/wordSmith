import 'package:flutter/material.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelTwo.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';
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
        'SingleLevelOne':(context)=>SingleLevelOne(),
        'SingleLevelTwo':(context)=>SingleLevelTwo()
        

      },
    );
  }
}