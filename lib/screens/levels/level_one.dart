import 'package:flutter/material.dart';
import 'package:wordsmith/screens/levels/level_one_entry.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LevelOne extends StatefulWidget {
  @override
  _LevelOneState createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Center(
                child: TextLiquidFill(
                  text: 'LIQUIDY',
                  waveColor: Colors.blueAccent,
                  boxBackgroundColor: Colors.redAccent,
                  textStyle: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                  boxHeight: 300.0,
                  boxWidth: 250.0,
                ),
              ),
              FlatButton(
                  child: Text('Start', style: TextStyle(color: Colors.white)),
                  color: Colors.lightBlue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LevelOneEntry();
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
