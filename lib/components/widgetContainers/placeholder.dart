import 'package:flutter/material.dart';
import 'package:wordsmith/core/utilities/alphabetTile.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    Key key,
    @required this.entryHandler,
    @required this.letterMap,
    @required this.gameWord,
    @required this.listKey,
    @required this.gamePlay,
    @required this.animationController,
    @required this.leftButtonTap,
    @required this.rightButtonTap,
    this.dragTargetTrigger,
  }) : super(key: key);

  final EntryHandler entryHandler;
  final MappedLetters letterMap;
  final String gameWord;
  final GlobalKey<AnimatedListState> listKey;
  final GamePlayData gamePlay;
  final AnimationController animationController;
  final Function leftButtonTap;
  final Function rightButtonTap;

  final Function(AlphabetDetail) dragTargetTrigger;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAccept: (AlphabetDetail alphabetDetail) {
        print('Entering the chamber');
        return alphabetDetail.active == true;
        // return true;
      },
      onAccept: dragTargetTrigger,
      builder: (context, x, y) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            color: Colors.white.withOpacity(.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                      child: Icon(Icons.delete_forever,
                          color: Colors.red[800], size: 30.0),
                      onTap: leftButtonTap),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                        entryHandler.alphabetHandler.newAlpha.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(Icons.send,
                            color: Colors.brown[800], size: 30.0),
                        onPressed: rightButtonTap),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
