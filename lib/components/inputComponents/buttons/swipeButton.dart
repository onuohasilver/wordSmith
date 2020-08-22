import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';

class SwipeButton extends StatelessWidget {
  SwipeButton({
    Key key,
    @required this.entryHandler,
    @required this.gamePlay,
    @required this.gameWord,
    @required this.listKey,
    @required this.animationController,
    @required this.height,
    @required this.width,
    this.allowUpload = false,
  }) : super(key: key);

  final EntryHandler entryHandler;
  final GamePlayData gamePlay;
  final String gameWord;
  final GlobalKey<AnimatedListState> listKey;
  final AnimationController animationController;
  final double height;
  final double width;
  final bool allowUpload;
  final Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    Data userData = Provider.of<Data>(context);
    return GestureDetector(
      onVerticalDragEnd: (vertical) async {
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

        upload(bool upload) async {
          if (upload) {
            Map activeGamesMap;
            await firestore
                .collection('users')
                .document(userData.currentUserID)
                .get()
                .then((value) => activeGamesMap = value['activeGames ']);

            List currentUserWords = [allAlphabets];
            List currentUserValidList = [
              verifyWord(entryHandler.getGameWord(), allAlphabets)
            ];
            currentUserWords.addAll(activeGamesMap['currentUserWords']);
            currentUserValidList.addAll(activeGamesMap['currentUserValidList']);
            activeGamesMap['currentUserWords'] = currentUserWords;
            activeGamesMap['currentUserScore'] =
                entryHandler.scoreKeeper.scoreValue().toString();
            activeGamesMap['currentUserValidList'] = currentUserValidList;

            criteria
                ? firestore
                    .collection('users')
                    .document(userData.currentUserID)
                    .setData({
                    'activeGames ': activeGamesMap,
                  }, merge: true)
                : print('');
          }
        }

        upload(allowUpload);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
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
        width: width * .093,
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
