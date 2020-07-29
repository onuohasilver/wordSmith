import 'package:flutter/material.dart';
import 'package:wordsmith/screens/friendsScreen.dart';
import 'package:wordsmith/screens/levelSelectScreen.dart';
import 'package:wordsmith/screens/playerScreen.dart';
import 'package:wordsmith/screens/registerScreen.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelThree.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelTwo.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/screens/loadingScreen.dart';
import 'package:wordsmith/screens/signInScreen.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/userProvider/themeData.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Data()),
      ChangeNotifierProvider(create: (context) => AppThemeData())
    ],
    child: MaterialApp(
      initialRoute: 'LoadingScreen',
      debugShowCheckedModeBanner: false,
      routes: {
        'LevelSelect': (context) => SelectScreen(),
        'LoadingScreen': (context) => LoadingScreen(),
        'SingleLevelOne': (context) => SingleLevelOne(),
        'SingleLevelTwo': (context) => SingleLevelTwo(),
        'SingleLevelThree': (context) => SingleLevelThree(),
        'MultiLevelOne': (context) => MultiLevelOne(),

        'SignInPage': (context) => SignInPage(),
        'RegisterPage': (context) => RegisterScreen(),
        // 'ChooseOpponent': (context) => ChooseOpponent(),
        'PlayerScreen': (context) => PlayerScreen(),
        'FriendScreen': (context) => FriendScreen()
      },
    ),
  ));
}
