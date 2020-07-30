import 'package:flutter/material.dart';
import 'package:wordsmith/components/cardComponents/cards.dart';

class GamePlayTopRow extends StatelessWidget {
  const GamePlayTopRow({
    Key key,
    @required this.counter,
  }) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: LittleCard(
              child: Icon(Icons.arrow_back, color: Colors.white)),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'FriendScreen');
          },
        ),
        LittleCard(
          child: (counter > 7)
              ? Text(
                  '$counter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )
              : Text(
                  "$counter",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                ),
        ),
      ],
    );
  }
}
