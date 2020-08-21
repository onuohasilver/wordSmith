import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/screens/popUps/dialogs/waitingForOpponent.dart';

class OpponentUserCard extends StatelessWidget {
  ///display User Information with
  ///an option to either follow the user or
  ///send a game challenge.
  ///it defaults to a [Colors.lime] background container
  const OpponentUserCard(
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
    return Material(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(10),
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
            alignment: Alignment.topRight,
            child: Material(
              type: MaterialType.circle,
              color: Colors.black,
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.lime[600],
                  ),
                  onPressed: () async {
                    ///Display snackbar to notify user that
                    ///addition was successfully done.
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black,
                        duration: Duration(milliseconds: 160),
                        content: Center(
                          heightFactor: 1,
                          child: Text(
                            '$userName has been added as Friend',
                            style: GoogleFonts.poppins(color: Colors.lime[600]),
                          ),
                        ),
                      ),
                    );

                    List previousChallenges = await firestore
                        .collection('users')
                        .document(userData.currentUserID)
                        .get()
                        .then((value) => value['friends']);
                    List friends = [];
                    friends.addAll(previousChallenges);
                    friends.add(userID);
                    firestore
                        .collection('users')
                        .document(
                          userData.currentUserID,
                        )
                        .setData({'friends': friends}, merge: true);
                  }),
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
            alignment: Alignment.topLeft,
            child: StreamBuilder<DocumentSnapshot>(
              stream:
                  firestore.collection('users').document(userID).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                bool online = snapshot.data['online'];
                return Container(
                  height: height*.04,
                  width: width*.05,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Material(
                          type: MaterialType.circle,
                          color: online ? Colors.lime[600] : Colors.grey),
                    ));
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              elevation: 3,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return WaitingForOpponent(
                      height: height,
                      width: width,
                      firestore: firestore,
                      userID: userID,
                      opponentName: userName,
                    );
                  },
                );
                List previousChallenges = await firestore
                    .collection('users')
                    .document(userID)
                    .get()
                    .then((value) => value['challenges']);
                List challenges = [];
                challenges.addAll(previousChallenges);
                challenges.add(userData.currentUserID);
                firestore
                    .collection('users')
                    .document(
                      userID,
                    )
                    .setData({'challenges': challenges}, merge: true);

                ///Reset the current content of the activeGames
                ///document on firestore
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
              },
              child: Text(
                'Challenge',
                style: GoogleFonts.poppins(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
