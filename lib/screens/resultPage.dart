import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/levelSelect.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
            child: Text(
              widget.score.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
