import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
class SwipeButton extends StatelessWidget {
  const SwipeButton({
    Key key,
    @required this.entryHandler,
    @required this.gamePlay,
    @required this.gameWord,
    @required this.listKey,
    @required this.animationController,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final EntryHandler entryHandler;
  final GamePlayData gamePlay;
  final String gameWord;
  final GlobalKey<AnimatedListState> listKey;
  final AnimationController animationController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (vertical) {
        String allAlphabets = entryHandler.alphabetHandler.allAlphabets();
        entryHandler.alphabetHandler.reset();
        gamePlay.letterMap.reset();
        verifyWord(gameWord, allAlphabets)
            ? gamePlay.updateProgress()
            : gamePlay.updateProgress(increment: 0);
        bool criteria = allAlphabets.length >= 3;

        criteria ? entryHandler.insert(allAlphabets.trimLeft()) : Container();
        criteria
            ? listKey.currentState.insertItem(0, duration: Duration(seconds: 2))
            : Container();
        gamePlay.straightWins(entryHandler);
        gamePlay.straightThree
            ? animationController.repeat()
            : animationController.reset();
        gamePlay.updateDeck(entryHandler);
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.bounceInOut,
        height: gamePlay.deckEngaged ? height * .23 : height * .05,
        decoration: BoxDecoration(
          color: gamePlay.deckEngaged
              ? Colors.green
              : Colors.black.withOpacity(.4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: width * .08,
        child: gamePlay.deckEngaged
            ? Center(
                child: Text(
                  ' S \n W \n I\n P\n E',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: width * .04),
                ),
              )
            : Container(),
      ),
    );
  }
}

