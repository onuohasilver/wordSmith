import 'package:flutter/material.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelThree.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelTwo.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelThree.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelTwo.dart';
import 'package:wordsmith/screens/loadingScreen.dart';
import 'package:wordsmith/screens/signInScreen.dart';
import 'package:wordsmith/screens/LevelSelectScreen.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(context)=>Data(),
          child: MaterialApp(
        initialRoute: 'LoadingScreen',
        routes: {
          'LevelSelect': (context) => LevelSelectScreen(),
          'LoadingScreen': (context) => LoadingScreen(),
          'SingleLevelOne': (context) => SingleLevelOne(),
          'SingleLevelTwo': (context) => SingleLevelTwo(),
          'SingleLevelThree': (context) => SingleLevelThree(),
          'MultiLevelOne': (context) => MultiLevelOne(),
          'MultiLevelTwo': (context)=>MultiLevelTwo(),
          'MultiLevelThree': (context)=>MultiLevelThree(),
          'SignInPage': (context) => SignInPage(),
        },
      ),
    )
  );
}

