import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/screens/popUps/dialogs/waitingForOpponent.dart';

class RequestUserCard extends StatelessWidget {
  ///display User Information with
  ///an option to either follow the user or
  ///send a game challenge.
  ///it defaults to a [Colors.lime] background container
  const RequestUserCard(
      {Key key,
      @required this.width,
      @required this.userName,
      @required this.userID,
      @required this.height})
      : super(key: key);

  ///MediaQuery request on the width of the current context
  final double width;

  ///MediaQuery request on the height of the current context
  final double height;

  ///UserName of the current User being displayed gotten from an
  ///initial firebase request
  final String userName;

  ///UserID of the current User being displayed gotten from an
  ///initial firebase request
  final String userID;

  @override
  Widget build(BuildContext context) {
    Firestore firestore = Firestore.instance;
    final Data userData = Provider.of<Data>(context);
    return Container(
      height: height * .1,
      width: width * .3,
      child: Material(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: width * .08,
                    ),
                    backgroundColor: Colors.lime[600],
                    maxRadius: width * .07,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      userName,
                      style: GoogleFonts.poppins(color: Colors.lime[600]),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  elevation: 3,
                  onPressed: () async {
                    ///Add the challenging userID to accepted challenges
                    firestore
                        .collection('users')
                        .document(userData.currentUserID)
                        .setData({
                      'activeChallenges': [userID]
                    }, merge: true);

                    ///Reset active game content to empty
                    firestore
                        .collection('users')
                        .document(userData.currentUserID)
                        .setData({
                      'activeGames': {
                        'currentUserScore': 0,
                        'currentUserValidList': [],
                        'currentUserWords': []
                      }
                    }, merge: true);

                    ///remove challenging userID to from recieved challenges
                    ///

                    List previousChallenges = await firestore
                        .collection('users')
                        .document(userData.currentUserID)
                        .get()
                        .then((value) => value['challenges']);
                    List challenges = [];
                    challenges.addAll(previousChallenges);
                    challenges.remove(userID);
                    firestore
                        .collection('users')
                        .document(userData.currentUserID)
                        .setData({'challenges': challenges}, merge: true);
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MultiLevelOne(
                                opponentName: userName,
                                opponentID: userID,
                                randomIndex: 1);
                          }),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Accept',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
