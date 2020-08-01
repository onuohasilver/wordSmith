import 'dart:math' show pi;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/levelSelectCard.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/soundHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Animation animation;
  AnimationController animationController;
  GameSound gameSound;
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
  Widget build(BuildContext context) {
    // gameSound.playFile();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    gameSound = GameSound();
    AppThemeData theme = Provider.of<AppThemeData>(context);
    SoundData sound = Provider.of<SoundData>(context);
    // AudioPlayer player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    // AudioCache cache = AudioCache();
    animationController.repeat(reverse: true);
    gameSound.playFile();
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
                    Text(sound.playingBase.toString()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Material(
                            type: MaterialType.circle,
                            color: sound.playingBase
                                ? Colors.green[700]
                                : Colors.red,
                            child: IconButton(
                                icon: Icon(Icons.mic, color: Colors.white),
                                onPressed: () {
                               
                                  gameSound.stopFile();
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
