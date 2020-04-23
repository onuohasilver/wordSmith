import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LevelOne extends StatefulWidget {
  @override
  _LevelOneState createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Word is',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Text(
                'FERMENTATION',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
                  child: FlatButton(
                      child: Text('Start', style:TextStyle(color: Colors.white)),
                      color: Colors.lightBlue,
                      onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
