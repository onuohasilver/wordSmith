import 'package:flutter/material.dart';
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
      duration: Duration(seconds: 5),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    GradientSetter gradientSetter = GradientSetter();
    final Data appData = Provider.of<Data>(context);
    animationController.forward();

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, widget) {
          return Container(
            height: height,
            width: width,
            // decoration: gradientSetter.randomPair,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/wooden-wall.jpg'),fit: BoxFit.cover)),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('WORD SMITH',
                      textAlign: TextAlign.center, style: kTitleSelectText),
                  Transform(
                      transform: Matrix4.translationValues(
                          width * animation.value, 0, 0),
                      child: LevelCard(
                          label: 'SINGLE PLAYER',
                          routeName: 'SingleLevelOne')),
                  Transform(
                    transform: Matrix4.translationValues(
                        width * animation.value, 0, 0),
                    child: LevelCard(
                      label: 'MULTI-PLAYER',
                      routeName: 'SignInPage',
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CardButton(
                        icon: Icons.person,
                        height: height,
                        onTap: () {
                          Navigator.pushNamed(context, 'PlayerScreen');
                        },
                      ),
                      CardButton(
                        icon: Icons.color_lens,
                        height: height,
                        onTap: () {
                          setState(
                            () {
                              appData.updateTheme(gradientSetter.randomPair);
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
