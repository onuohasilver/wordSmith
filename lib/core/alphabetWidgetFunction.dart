import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/inputComponents/buttons/draggableAlphabets.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:meta/meta.dart';

/// Use the [entryHandler] data to generate [DraggableAlphabet] widgets
/// and also provide interactive function to manage the letterState in the
/// [GamePlayData] provider letterMap.
generateWidgets(
    {@required List<Widget> alphabetWidget,
    @required GamePlayData gamePlay,
    @required EntryHandler entryHandler}) {
  for (String alphabet in gamePlay.letterMap.map1.keys) {
    AlphabetDetail alphabetDetail = AlphabetDetail(
        alphabet: alphabet,
        active: gamePlay.letterMap.map1[alphabet],
        mapNumber: 1);
    alphabetWidget.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: DraggableAlphabet(
        alphabetDetail: alphabetDetail,
        onPressed: () {
          gamePlay.letterMap.map1[alphabet]
              ? gamePlay.updateLetterState(alphabetDetail, entryHandler)
              : gamePlay.removeLetter(alphabetDetail, entryHandler);
        },
      ),
    ));
  }
  for (String alphabet in gamePlay.letterMap.map2.keys) {
    AlphabetDetail alphabetDetail = AlphabetDetail(
        alphabet: alphabet,
        active: gamePlay.letterMap.map2[alphabet],
        mapNumber: 2);
    alphabetWidget.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: DraggableAlphabet(
        alphabetDetail: alphabetDetail,
        onPressed: () {
          gamePlay.letterMap.map2[alphabet]
              ? gamePlay.updateLetterState(alphabetDetail, entryHandler)
              : gamePlay.removeLetter(alphabetDetail, entryHandler);
        },
      ),
    ));
  }
}

class AlphabetWidgetDisplay extends StatefulWidget {
  final EntryHandler entryHandler;

  const AlphabetWidgetDisplay({Key key, @required this.entryHandler})
      : super(key: key);
  @override
  _AlphabetWidgetDisplayState createState() => _AlphabetWidgetDisplayState();
}

class _AlphabetWidgetDisplayState extends State<AlphabetWidgetDisplay> {
  @override
  void initState() {
    GamePlayData gamePlay = Provider.of<GamePlayData>(context, listen: false);
    gamePlay.setupLetterMap(widget.entryHandler);

    super.initState();
  }

  List<Widget> alphabetWidget = [];
  @override
  Widget build(BuildContext context) {
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    List<Widget> alphabetWidget = [];

    generateWidgets(
        alphabetWidget: alphabetWidget,
        gamePlay: gamePlay,
        entryHandler: widget.entryHandler);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: alphabetWidget,
      ),
    );
  }
}
