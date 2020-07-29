import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:wordsmith/screens/joinGameScreen.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/constants.dart';

class WaitingForOpponent extends StatelessWidget {
  const WaitingForOpponent(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.firestore,
      @required this.userID,
      @required this.opponentName})
      : super(key: key);

  final double height;
  final double width;
  final Firestore firestore;
  final String userID;
  final String opponentName;

  @override
  Widget build(BuildContext context) {
    final Data userData = Provider.of<Data>(context);
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: height * .2,
          width: width * .7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              blurBox,
              Text('Waiting for Opponnent!', style: GoogleFonts.poppins()),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lime[800]),
              ),
              GameStream(
                firestore: firestore,
                userID: userID,
                userData: userData,
                opponentName: opponentName,
              ),
              RaisedButton(
                child: Text(
                  'x Cancel Challenge',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                color: Colors.red[600],
                onPressed: () async {
                  List previousChallenges = await firestore
                      .collection('users')
                      .document(userID)
                      .get()
                      .then((value) => value['challenges']);
                  List challenges = [];
                  challenges.addAll(previousChallenges);
                  challenges.remove(userData.currentUserID);
                  firestore
                      .collection('users')
                      .document(
                        userID,
                      )
                      .setData({'challenges': challenges}, merge: true);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}

class GameStream extends StatelessWidget {
  const GameStream({
    Key key,
    @required this.firestore,
    @required this.userID,
    @required this.userData,
    this.opponentName,
  }) : super(key: key);

  final Firestore firestore;
  final String userID;
  final Data userData;
  final String opponentName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestore.collection('users').document(userID).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List activeGames = snapshot.data['activeGames'];
            print(activeGames);
            if (activeGames.contains(userData.currentUserID)) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MultiLevelOne(
                          opponentName: opponentName,
                          opponentID: userID,
                          randomIndex: 1);
                    }),
                  );
                },
              );
            }
            return Container();
          }
          return Container();
        });
  }
}
