import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/userProvider/themeData.dart';

import 'package:wordsmith/utilities/constants.dart';
import 'package:wordsmith/utilities/localData.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  Animation flipAnimation;
  LocalData localData = LocalData();
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    animation = Tween(begin: 0.5, end: 1.0).animate(animationController);
    flipAnimation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String loggedInUserId;
  getUserDetails() async {
    final loggedInUser = await _auth.currentUser();
    loggedInUserId = loggedInUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    _highScore() async {
      final playerHighScore = await localData.highScore;
      setState(() {
        highScore = playerHighScore;
      });
    }

    _highScore();

    // final Data appData = Provider.of<Data>(context);
    final AppThemeData theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    animationController.repeat();
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return SingleChildScrollView(
            child: Container(
              decoration: theme.background,
              height: height,
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: height * .13),
                  blurBox,
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white.withOpacity(.2),
                    child:
                        Icon(Icons.person, size: 43, color: Colors.brown[900]),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('users').snapshots(),
                      builder: (context, snapshot) {
                        final _users = snapshot.data.documents;
                        String _userName;
                        for (var user in _users) {
                          if (user.data['userid'] == loggedInUserId) {
                            _userName = user.data['username'];
                          }
                        }
                        return Container(
                          width: width * .5,
                          child: Stack(children: [
                            Text(
                              _userName,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  shadows: [Shadow(blurRadius: 30)]),
                            ),
                            Positioned.fill(
                              right: width*.02,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  maxRadius: width * .02,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            )
                          ]),
                        );
                      }),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                    height: height * .55,
                    width: width * .9,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          bottom: height * .15,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ScoreCard(
                              content: '',
                              title: '',
                              iconPath:'assets/settings.png' ,
                              height: height * 1.3,
                              width: width * 1.3,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          bottom: height * .15,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ScoreCard(
                                content: '',
                                title: '',
                                height: height * 1.3,
                                width: width * 1.3,
                                iconPath:'assets/logOff.png' ),
                          ),
                        ),
                        Positioned.fill(
                          // bottom: height * .15,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: ScoreCard(
                              content: '',
                              title: '',
                              iconPath:'assets/people.png' ,
                              height: height * 1.3,
                              width: width * 1.3,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          // bottom: height * .15,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ScoreCard(
                              content: '',
                              iconPath:'assets/ff2.png' ,
                              title: '',
                              height: height * 1.3,
                              width: width * 1.3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .04,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: height * .1,
                              width: width * .6,
                              child: Material(
                                color: Colors.lightGreen[400],
                                elevation: 40,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                    splashColor: Colors.green[900],
                                    onTap: () => Navigator.pushReplacementNamed(
                                        context, 'ChooseOpponent'),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Center(
                                        child: Icon(Icons.settings_input_svideo,
                                            size: 40))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
