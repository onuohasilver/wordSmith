import 'package:wordsmith/utilities/entryHandler.dart';

class ScoreKeeper{
  List<bool> scoresTruthList= [];
  List<int> scoresLengthList=[];

  void getScores(validated,entry){
    scoresTruthList.add(validated);
    scoresLengthList.add(entry.length);
  }

}