import 'dart:math' show Random, pi;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/levelSelectCard.dart';
import 'package:wordsmith/components/widgetContainers/levelCircle.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/levelModel.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/soundHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';

class AdventureScreen extends StatefulWidget {
  @override
  _AdventureScreenState createState() => _AdventureScreenState();
}
class _AdventureScreenState extends State<AdventureScreen>
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
    // gameSound.quit();
    // gameSound.stopFile();
  }

  @override
  Widget build(BuildContext context) {
    // gameSound.playFile();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // gameSound = GameSound();
    AppThemeData theme = Provider.of<AppThemeData>(context);
    // SoundData sound = Provider.of<SoundData>(context);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                blurBox,
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: levelMap['displace'].length,
                      itemBuilder: (context, index) {
                        // int colorCode=Random().nextInt(8);
                        return LevelCircle(
                            height: height,
                            width: width,
                            index:index,
                            displace: levelMap['displace'][index],
                            color: Colors.green.shade800,
                            label: 'Level ${index+1}');
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
