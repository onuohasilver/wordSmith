import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: appData.theme,
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            SizedBox(height: height * .2),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white.withOpacity(.2),
              child: Icon(Icons.person, size: 43, color: Colors.white),
            ),
            SizedBox(
              height: height * .05,
            ),
            Container(
              height: height * .5,
              width: width * .9,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ScoreCard(
                          height: height,
                          width: width,
                          title: 'High Score',
                          content: '95'),
                      ScoreCard(
                        height: height,
                        width: width,
                        title: 'Rank',
                        content: '109',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  ScoreCard(
                    content: 'SKIRMISH',
                    width: width * 2,
                    height: height,
                    title: 'Best Word',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.title,
      @required this.content})
      : super(key: key);

  final double height;
  final double width;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * .1,
        width: width * .4,
        child: Material(

          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: (){},
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                content,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(.2),
        ),
      ),
    );
  }
}
