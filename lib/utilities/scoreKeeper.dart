class ScoreKeeper {
  List<bool> scoresTruthList = [];
  List<int> scoresLengthList = [];

  void getScores(validated, entry) {
    scoresTruthList.add(validated);
    scoresLengthList.add(entry.length);
  }

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
