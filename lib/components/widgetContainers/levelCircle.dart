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
    @required this.index,
    @required this.active,
  }) : super(key: key);

  final double height;
  final double width;
  final double displace;
  final Color color;
  final int index;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: width * .4 * displace,
        ),
        Container(
          height: height * .12,
          width: width * .16,
          child: Material(
            color: active ? Colors.white : Colors.black54,
            type: MaterialType.circle,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Material(
                elevation: 10,
                type: MaterialType.circle,
                color: active ? color : Colors.grey,
                child: InkWell(
                  customBorder: CircleBorder(),
                  child: active
                      ? Icon(Icons.lock_open, color: Colors.yellow)
                      : Icon(Icons.lock),
                  onTap: active
                      ? () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  SingleLevelOne(wordIndex: index),
                            ),
                          )
                      : () {},
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
                color: active ? Colors.yellow[800] : Colors.grey,
              ),
              Icon(Icons.star, color: Colors.grey[600]),
              Icon(
                Icons.star,
                color: Colors.grey[600],
              )
            ]),
            Material(
                color: active ? color : Colors.grey,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                        color: active ? Colors.white60 : Colors.white),
                  ),
                )),
          ]),
        ),
        SizedBox(
          width: width * .1 * displace,
        ),
      ]),
    );
  }
}
