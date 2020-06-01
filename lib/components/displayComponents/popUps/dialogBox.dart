import 'package:flutter/material.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
dialogBox(context, String score, String level) {
  showDialog(
      context: context,
      barrierDismissible: true,

      //TODO: Change ui of the AlertPopup
      child: AlertDialog(
        shape:RoundedRectangleBorder(),
          backgroundColor: Colors.blue.withOpacity(.4),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
      LittleCard(
          child: Text(
        'SCORE: $score',
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w300),
      )),
      SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, level);
          },
          child: LittleCard(
            child: Icon(
              Icons.forward,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        LittleCard(
          child: Icon(Icons.backspace, color: Colors.white, size: 40),
        ),
      ])
            ],
          ),
        ));
}

multiDialogBox(context, int scoreChallenger, int scoreOpponent, String level) {
  String winner(){
    if(scoreChallenger>scoreOpponent){
      return 'You Win';
    }else{
      return 'You Lose';
    }

  }
  showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        
        backgroundColor: Colors.blue.withOpacity(.4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LittleCard(
                child: Text(
              winner(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            )),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, level);
                },
                child: LittleCard(
                  child: Icon(
                    Icons.forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              LittleCard(
                child: Icon(Icons.backspace, color: Colors.white, size: 40),
              ),
            ])
          ],
        ),
      ));
}