import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
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
    @required this.starRating,
  }) : super(key: key);

  final double height;
  final double width;
  final double displace;
  final Color color;
  final int index;
  final String label;
  final bool active;
  final String starRating;

  @override
  Widget build(BuildContext context) {
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      ? () {
                          gamePlay.resetProgress();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  SingleLevelOne(wordIndex: index),
                            ),
                          );
                        }
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
              StarIcon(active: active, starRating: starRating, value: 1),
              StarIcon(active: active, starRating: starRating, value: 2),
              StarIcon(active: active, starRating: starRating, value: 3)
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
        // SizedBox(
        //   width: width * .2 * displace,
        // ),
      ]),
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    Key key,
    @required this.active,
    @required this.starRating,
    @required this.value,
  }) : super(key: key);

  final bool active;
  final String starRating;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color:
          ((int.parse(starRating)) >= value) ? Colors.yellow[800] : Colors.grey,
    );
  }
}
//TODO: Check the
