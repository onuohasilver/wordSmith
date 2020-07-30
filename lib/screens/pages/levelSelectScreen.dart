import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/levelSelectCard.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final AppThemeData theme = Provider.of<AppThemeData>(context);
    animationController.repeat(reverse: true);

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
                              routeName: 'SingleLevelOne',
                              height: height,
                              width: width,
                            ),
                          ),
                        ],
                      ),
                    ),
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
