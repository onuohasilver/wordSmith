/// ScoreKeeper keeps track of the user gameplay
/// scores as a list of [bool] values
/// and also a list of [int] values
class ScoreKeeper {
  ///record of the correct and false records, interpreted as [bool] objects
  ///[true] means correct
  ///[false] means false
  List<bool> scoresTruthList = [];
  List<int> scoresLengthList = [];

  ///obtain the scores when a compared value
  ///is validated as true
  void getScores(validated, entry) {
    scoresTruthList.add(validated);
    scoresLengthList.add(entry.length);
  }
  void zero() {
    scoresTruthList.add(false);
    scoresLengthList.add(0);
  }


  ///use scoreValue to get the score as an [int]
  int scoreValue() {
    int score = 0;
    if (scoresLengthList.length > 0) {
      scoresLengthList.forEach((scoreIndex) {
        score = score + scoreIndex;
      });
    }
    return score;
  }
}
