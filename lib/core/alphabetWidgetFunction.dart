import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/inputComponents/buttons/draggableAlphabets.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:meta/meta.dart';

generateWidgets(
    {@required List<Widget> alphabetWidget,
    @required GamePlayData gamePlay,
    @required EntryHandler entryHandler}) {
  for (var alphabet in gamePlay.letterMap.map1.keys) {
    AlphabetDetail alphabetDetail = AlphabetDetail(
        alphabet: alphabet, active: gamePlay.letterMap.map1[alphabet]);
    alphabetWidget.add(DraggableAlphabet(
      alphabet: alphabet,
      active: gamePlay.letterMap.map1[alphabet],
      onPressed: () {
        gamePlay.updateLetterState(alphabetDetail, entryHandler);
      },
    ));
  }
  for (var alphabet in gamePlay.letterMap.map2.keys) {
    AlphabetDetail alphabetDetail = AlphabetDetail(
        alphabet: alphabet, active: gamePlay.letterMap.map2[alphabet]);
    alphabetWidget.add(DraggableAlphabet(
      alphabet: alphabet,
      active: gamePlay.letterMap.map2[alphabet],
      onPressed: () {
        gamePlay.updateLetterState(alphabetDetail, entryHandler);
      },
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
    // generateWidgets(
    //     alphabetWidget: alphabetWidget,
    //     gamePlay: gamePlay,
    //     entryHandler: widget.entryHandler);
    super.initState();
  }

  List<Widget> alphabetWidget = [];
  @override
  Widget build(BuildContext context) {
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    List<Widget> alphabetWidget = [];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    generateWidgets(
        alphabetWidget: alphabetWidget,
        gamePlay: gamePlay,
        entryHandler: widget.entryHandler);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth:width*.6),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: alphabetWidget,
      ),
    );
  }
}
