import 'package:flutter/material.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelThree.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelTwo.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/screens/loadingScreen.dart';
import 'package:wordsmith/screens/signInScreen.dart';
import 'package:wordsmith/screens/LevelSelectScreen.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(context)=>UserData(),
          child: MaterialApp(
        initialRoute: 'SignInPage',
        routes: {
          'LevelSelect': (context) => LevelSelectScreen(),
          'LoadingScreen': (context) => LoadingScreen(),
          'SingleLevelOne': (context) => SingleLevelOne(),
          'SingleLevelTwo': (context) => SingleLevelTwo(),
          'SingleLevelThree': (context) => SingleLevelThree(),
          'MultiLevelOne': (context) => MultiLevelOne(),
          'SignInPage': (context) => SignInPage(),
        },
      ),
    )
  );
}

