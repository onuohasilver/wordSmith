import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/levelSelectCard.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/core/utilities/constants.dart';
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
    gameSound.quit();
    gameSound.stopFile();
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
                  child: ListView(
                    children: <Widget>[
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .1,
                      ),
                      LevelCircle(
                          height: height,
                          width: width,
                          displace: .12,
                          color: Colors.lime[700]),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .14,
                        color: Colors.yellow[600],
                      ),
                      LevelCircle(
                          height: height,
                          width: width,
                          displace: .2,
                          color: Colors.lime[700]),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .22,
                        color: Colors.lime[800],
                      ),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .24,
                      ),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .26,
                      ),
                      LevelCircle(
                          height: height,
                          width: width,
                          displace: .3,
                          color: Colors.lime[700]),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .32,
                        color: Colors.yellow[600],
                      ),
                      LevelCircle(
                          height: height,
                          width: width,
                          displace: .3,
                          color: Colors.lime[700]),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .2,
                        color: Colors.lime[800],
                      ),
                      LevelCircle(
                        height: height,
                        width: width,
                        displace: .1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LevelCircle extends StatelessWidget {
  const LevelCircle({
    Key key,
    @required this.height,
    @required this.width,
    @required this.displace,
    this.color,
  }) : super(key: key);

  final double height;
  final double width;
  final double displace;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(children: [
        SizedBox(
          width: width * displace,
        ),
        Container(
          height: height * .12,
          width: width * .16,
          child: Material(
            elevation: 10,
            type: MaterialType.circle,
            color: color ?? Colors.brown[700],
            child: InkWell(customBorder:CircleBorder(),onTap:(){}),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(children: [
            Row(children: <Widget>[
              Icon(Icons.star,color: Colors.yellow[800],),
              Icon(Icons.star,color:Colors.grey[600]),
              Icon(Icons.star,color: Colors.grey[600],)
            ]),
            Material(
                color: color ?? Colors.brown[700],
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(' Level 2',
                      style: GoogleFonts.poppins(color: Colors.black)),
                )),
          ]),
        )
      ]),
    );
  }
}
