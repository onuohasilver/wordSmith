import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/utilities/constants.dart';

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
                },
              ),
            ),
            SlimButton(
              label: 'Join Game',
              useWidget: false,
              color: Colors.lightBlueAccent.shade700,
              textColor: Colors.white,
              onTap: () {
                setState(() {
                  startSpin = !startSpin;
                });

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiLevelOne(
                      opponentName: widget.opponentName,
                      opponentID: widget.opponentID,
                      currentUserName: widget.currentUserName,
                      currentUserID: widget.currentUserID,
                      opponentGameID: userData.opponentGameID,
                      currentUserGameID: userData.challengerGameID);
                }));
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
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    startSpin = false;
    super.dispose();
  }
}
