import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';

class GameStream extends StatelessWidget {
  ///Stream Listener that carries out the [WaitingForOpponent] functionality
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
            List activeGames = snapshot.data['acceptedChallenges'];
            print(activeGames);
            if (activeGames.contains(userData.currentUserID)) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pushReplacement(
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
