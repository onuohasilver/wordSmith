import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/screens/singlePlayerLevels/singleLevelOne.dart';

class LevelCircle extends StatelessWidget {
  const LevelCircle({
    Key key,
    @required this.height,
    @required this.width,
    @required this.displace,
    this.color,
    @required this.label,
    this.index,
  }) : super(key: key);

  final double height;
  final double width;
  final double displace;
  final Color color;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(children: [
        SizedBox(
          width: width * displace,
        ),
        Container(
          height: height * .12,
          width: width * .16,
          child: Material(
            elevation: 10,
            type: MaterialType.circle,
            color: color ?? Colors.brown[700],
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SingleLevelOne(wordIndex: index),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(children: [
            Row(children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.yellow[800],
              ),
              Icon(Icons.star, color: Colors.grey[600]),
              Icon(
                Icons.star,
                color: Colors.grey[600],
              )
            ]),
            Material(
                color: color ?? Colors.brown[700],
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(color: Colors.white60),
                  ),
                )),
          ]),
        )
      ]),
    );
  }
}
