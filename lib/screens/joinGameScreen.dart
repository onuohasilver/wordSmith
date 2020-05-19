import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/screens/setupGameScreen.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinGameScreen extends StatefulWidget {
  final String opponentName;
  final String opponentID;
  final String currentUserName;
  final String currentUserID;

  JoinGameScreen({
    this.opponentName,
    this.opponentID,
    this.currentUserName,
    this.currentUserID,
  });
  @override
  _JoinGameScreenState createState() => _JoinGameScreenState();
}

bool startSpin = false;
Firestore _firestore = Firestore.instance;
List<String> activeGames = [];
List<String> activeGamesL = [];
int randomIndex;

class _JoinGameScreenState extends State<JoinGameScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Data>(context);
    return Scaffold(
      body: Container(
        decoration: kPurpleScreenDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('😎😺',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.lightBlueAccent.withOpacity(.1))),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 3.0, 18.0, 3.0),
              child: InputText(
                userData: userData,
                hintText: 'Enter a Game ID',
                enforceLength: 8,
                obscure: false,
                keyboardType: TextInputType.text,
                onChanged: (String gameID) {
                  String gameIDreversed = gameID.split('').reversed.join();
                  userData.updateGameID(gameIDreversed);
                  activeGames.add(gameID);
                },
              ),
            ),
            SlimButton(
              label: 'Join Game',
              useWidget: false,
              color: Colors.lightBlueAccent.shade700,
              textColor: Colors.white,
              onTap: () async {
                setState(() {
                  startSpin = !startSpin;
                });
                _firestore
                    .collection('activeGames')
                    .document('active')
                    .setData({'active': activeGames}, merge: true);
                await _firestore
                    .collection('entry')
                    .document(userData.challengerGameID)
                    .get()
                    .then((snapshot) {
                  randomIndex = snapshot.data['randomIndex'];
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return MultiLevelOne(
                              opponentName: widget.opponentName,
                              opponentID: widget.opponentID,
                              currentUserName: widget.currentUserName,
                              currentUserID: widget.currentUserID,
                              opponentGameID: userData.opponentGameID,
                              currentUserGameID: userData.challengerGameID,
                              randomIndex: randomIndex);
                        },
                        maintainState: false));
              },
            ),
            SizedBox(
                child: SpinKitThreeBounce(
                    color:
                        startSpin ? Colors.lightBlueAccent : Colors.transparent,
                    size: 50)),
            SizedBox(
              height: 40,
            ),
            Text(
              'Enter GameID to proceed to game Screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(.5),
              ),
            ),
            Column(
              children: <Widget>[
                StreamBuilder<DocumentSnapshot>(
                    stream: _firestore
                        .collection('activeGames')
                        .document('active')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> entryWidgets = [Text('')];
                      if (snapshot.hasData) {
                        final entryCore = snapshot.data.data;
                        final entry = entryCore['active'];
                        for (var entryX in entry) {
                          activeGamesL.add(entryX);
                        }
                      }
                      return Wrap(children: entryWidgets);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    startSpin = false;
    activeGames = [];
    super.dispose();
  }
}
