import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/screens/levels/level_one_entry.dart';

class ResultPage extends StatefulWidget {
  final score;
  ResultPage({this.score});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.lightBlueAccent],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[Text(
              widget.score.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
            ),
            FlatButton(onPressed: (){

            }, child: null)] 
          ),
        ),
      ),
    );
  }
}

