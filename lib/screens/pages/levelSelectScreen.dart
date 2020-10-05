import 'dart:async';
import 'dart:math' show pi;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/levelSelectCard.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/core/timer.dart';
import 'package:wordsmith/core/utilities/localData.dart';
import 'package:wordsmith/handlers/dataHandlers/dataSources/networkRequest.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/abstract.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/soundHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/sqlCache.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/screens/popUps/dialogs/levelComplete.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Animation animation;
  AnimationController animationController;
  int counter = 5;
  GameSound gameSound;
  String lo = 'hhhh';
  bool show = false;
  Timer timer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        gameSound.stopFile();
        break;
      case AppLifecycleState.paused:
        gameSound.stopFile();
        break;
      case AppLifecycleState.resumed:
        gameSound.stopFile();
        break;
      case AppLifecycleState.detached:
        gameSound.stopFile();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    // gameSound.playFile();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    gameSound = GameSound();
    AppThemeData theme = Provider.of<AppThemeData>(context);
    AbstractData abstract = Provider.of<AbstractData>(context);
    // SoundData sound = Provider.of<SoundData>(context);
    SqlCache sqlCache = Provider.of<SqlCache>(context);
    // AudioPlayer player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    // AudioCache cache = AudioCache();
    animationController.repeat(reverse: true);
    // gameSound.playFile();
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, widget) {
          return Container(
            height: height,
            width: width,
            decoration: theme.background,
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    WordCraftLogo(
                      width: width,
                      height: height,
                      animation: animation,
                    ),
                    Container(
                      height: height * .33,
                      width: width,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Transform.rotate(
                                angle: pi / 30 * animation.value,
                                child: LevelCard(
                                    label: 'MULTI-PLAYER',
                                    routeName: 'SignInPage',
                                    height: height,
                                    controller: animationController,
                                    width: width),
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -pi / 30 * animation.value,
                            child: LevelCard(
                              label: 'SINGLE PLAYER',
                              routeName: 'AdventureScreen',
                              height: height,
                              width: width,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .1),
                    Text(abstract.display.toString()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Material(
                            type: MaterialType.circle,
                            color: Colors.red,
                            child: IconButton(
                                icon: Icon(Icons.mic, color: Colors.white),
                                onPressed: () {
                                  // widgetTimer(abstract);
                                }),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
