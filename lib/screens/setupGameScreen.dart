import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/components.dart';
import 'package:provider/provider.dart';

class SetupGameScreen extends StatefulWidget {
  final String opponentName;
  final String opponentID;
  final String currentUserName;
  final String currentUserID;

  SetupGameScreen({
    this.opponentName,
    this.opponentID,
    this.currentUserName,
    this.currentUserID,
  });
  @override
  _SetupGameScreenState createState() => _SetupGameScreenState();
}

bool startSpin = false;
String challengerGameID;
String opponentGameID;

class _SetupGameScreenState extends State<SetupGameScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Data>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700], Colors.purple[400]],
          ),
        ),
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
                keyboardType: TextInputType.text,
                onChanged: (String gameID) {
                  setState(() {
                    opponentGameID = gameID;
                    challengerGameID = gameID.split('').reversed.join();
                  });
                },
              ),
            ),
            SlimButton(
              label: 'Create Game',
              useWidget: false,
              color: Colors.lightBlueAccent.shade700,
              textColor: Colors.white,
              onTap: () {
                print(challengerGameID);
                print(opponentGameID);
                setState(() {
                  startSpin = !startSpin;
                });
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
              'Game ID should consist of eight characters',
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
}
