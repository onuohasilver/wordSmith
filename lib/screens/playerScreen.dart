import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/localData.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  LocalData localData = LocalData();
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
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

    final appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    animationController.repeat();
    return Scaffold(
      body: Container(
        decoration: appData.theme,
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            SizedBox(height: height * .2),
            FadeTransition(
              opacity: animation,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white.withOpacity(.2),
                child: Icon(Icons.person, size: 43, color: Colors.white),
              ),
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
                  return Text(_userName,style: TextStyle(color: Colors.white, fontSize: 20),);
                }),
            
            SizedBox(
              height: height * .05,
            ),
            Container(
              height: height * .5,
              width: width * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ScoreCard(
                          height: height,
                          width: width,
                          title: 'High Score',
                          content: '$highScore'),
                      ScoreCard(
                        height: height,
                        width: width,
                        title: 'Rank',
                        content: '109',
                      ),
                    ],
                  ),
                  SizedBox(height: height * .05),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ScoreCard(
                      content: '34',
                      title: 'Losses',
                      height: height,
                      width: width * .6,
                    ),
                    ScoreCard(
                      content: '34',
                      title: 'Losses',
                      height: height,
                      width: width * .6,
                    ),
                    ScoreCard(
                      content: '34',
                      title: 'Losses',
                      height: height,
                      width: width * .6,
                    ),
                  ]),
                  SizedBox(
                    height: height * .04,
                  ),
                  Container(
                    height: height * .1,
                    width: width * .6,
                    child: Material(
                      color: Colors.lightGreen[400],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                          splashColor: Colors.green[900],
                          onTap: () => Navigator.pushReplacementNamed(
                              context, 'ChooseOpponent'),
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                              child:
                                  Icon(Icons.settings_input_svideo, size: 40))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
