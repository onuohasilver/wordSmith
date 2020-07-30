/// ScoreKeeper keeps track of the user gameplay
/// scores as a list of [bool] values
/// and also a list of [int] values
class ScoreKeeper {
  List<bool> scoresTruthList = [];
  List<int> scoresLengthList = [];
///obtain the scores when a compared value
///is validated as true
  void getScores(validated, entry) {
    scoresTruthList.add(validated);
    scoresLengthList.add(entry.length);
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
