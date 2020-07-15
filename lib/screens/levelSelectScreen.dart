import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';

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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    GradientSetter gradientSetter = GradientSetter();
    final Data appData = Provider.of<Data>(context);
    animationController.repeat(reverse: true);

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, widget) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/wooden-wall.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: height * .3,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'WORD',
                              textAlign: TextAlign.center,
                              style: kTitleSelectText.copyWith(
                                  color: Colors.brown[900],
                                  fontSize: height * .18),
                            ),
                          ),
                          Positioned.fill(
                            top: height * .18,
                            child: Text(
                              'CRAFT',
                              textAlign: TextAlign.center,
                              style: kTitleSelectText.copyWith(
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                        ],
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
                    Transform.rotate(
                      angle: pi / 30 * animation.value,
                      child: LevelCard(
                          label: 'MULTI-PLAYER',
                          routeName: 'SignInPage',
                          height: height,
                          width: width),
                    ),
                    // ButtonBar(
                    //   alignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     CardButton(
                    //       icon: Icons.person,
                    //       height: height,
                    //       onTap: () {
                    //         Navigator.pushNamed(context, 'PlayerScreen');
                    //       },
                    //     ),
                    //     CardButton(
                    //       icon: Icons.color_lens,
                    //       height: height,
                    //       onTap: () {
                    //         setState(
                    //           () {
                    //             appData.updateTheme(gradientSetter.randomPair);
                    //           },
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // )
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
