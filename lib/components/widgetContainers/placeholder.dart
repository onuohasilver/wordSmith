import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            height: height * .08,
            width: width * .9,
            color: Colors.white.withOpacity(.4),
            child: Stack(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entryHandler.alphabetHandler.newAlpha.length,
                        itemBuilder: (context, index) {
                          List textObject =
                              entryHandler.alphabetHandler.newAlpha;
                          AlphabetDetail alphabetDetail = AlphabetDetail(
                              alphabet: textObject[index],
                              active: true,
                              mapNumber: null);
                          return AlphabetButton(
                            alphabetDetail: alphabetDetail,
                            sizeRatio: .6,
                            textColor: Colors.white,
                            bgTile: 'assets/pngwave(2).png',
                          );
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
