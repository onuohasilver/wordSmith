import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/handlers/stateHandlers/streamLogic/waitingGameStream.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';

class WaitingForOpponent extends StatelessWidget {
  ///A popup streambuilder widget that listens for changes
  ///in the opponent user's [acceptedChallenges] document
  ///on firestore and pushes to the gameplay screen
  ///once the sent challenge has been accepted
  const WaitingForOpponent(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.firestore,
      @required this.userID,
      @required this.opponentName})
      : super(key: key);

  /// MediaQuery request on the height of the current context
  final double height;

  /// MediaQuery request on the width of the current context
  final double width;

  /// Firestore Instance
  final Firestore firestore;

  /// Opponent UserID
  final String userID;

  ///Opponent Username
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

