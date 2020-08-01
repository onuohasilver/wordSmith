import 'package:flutter/material.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/screens/pages/adventureScreen.dart';
import 'package:wordsmith/screens/pages/allUsersScreen.dart';
import 'package:wordsmith/screens/pages/friendsScreen.dart';
import 'package:wordsmith/screens/pages/levelSelectScreen.dart';
import 'package:wordsmith/screens/pages/loadingScreen.dart';
import 'package:wordsmith/screens/pages/playerScreen.dart';
import 'package:wordsmith/screens/pages/registerScreen.dart';
import 'package:wordsmith/screens/pages/signInScreen.dart';
// import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:provider/provider.dart';

import 'handlers/stateHandlers/providerHandlers/soundHandler.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Data()),
      ChangeNotifierProvider(create: (context) => AppThemeData()),
      ChangeNotifierProvider(create: (context) => SoundData()),
    ],
    ///TODO: Use resoCoders routeGenerator pattern
    child: MaterialApp(
      initialRoute: 'LoadingScreen',
      debugShowCheckedModeBanner: false,
      routes: {
        'LevelSelect': (context) => SelectScreen(),
        'LoadingScreen': (context) => LoadingScreen(),
       
        'MultiLevelOne': (context) => MultiLevelOne(),
        'SignInPage': (context) => SignInPage(),
        'RegisterPage': (context) => RegisterScreen(),
        'PlayerScreen': (context) => PlayerScreen(),
        'FriendScreen': (context) => FriendScreen(),
        'AllUsersScreen': (context) => AllUsersScreen(),
        'AdventureScreen':(context)=>AdventureScreen()
      },
    ),
  ));
}
