import 'package:sg_easy_hire/features/personal_test/data/models/question.dart';

class TestResult {
  TestResult({
    required this.type,
    required this.rawEI,
    required this.rawSN,
    required this.rawTF,
    required this.rawJP,
    required this.eiPct,
    required this.snPct,
    required this.tfPct,
    required this.jpPct,
  });
  final String type;
  final int rawEI, rawSN, rawTF, rawJP;
  final int eiPct, snPct, tfPct, jpPct;

  String get eiLetter => rawEI >= 0 ? 'E' : 'I';
  String get snLetter => rawSN >= 0 ? 'S' : 'N';
  String get tfLetter => rawTF >= 0 ? 'T' : 'F';
  String get jpLetter => rawJP >= 0 ? 'J' : 'P';
}

TestResult computeResult(List<Question> qs) {
  // Initialize scores for each pole
  int scoreE = 0,
      scoreI = 0,
      scoreN = 0,
      scoreS = 0,
      scoreT = 0,
      scoreF = 0,
      scoreJ = 0,
      scoreP = 0;
  int scoreA = 0, scoreTurb = 0; // For identity

  for (var q in qs) {
    final option = q.userAnswer;
    final score = option?.answerScore ?? 0;

    final pole = (option?.answerPole ?? '').toUpperCase();
    switch (q.dimension.toLowerCase()) {
      case 'mind':
        if (pole == 'EXTRAVERTED') scoreE += score;
        if (pole == 'INTROVERTED') scoreI += score;
        break;
      case 'energy':
        if (pole == 'INTUITIVE') scoreN += score;
        if (pole == 'OBSERVANT') scoreS += score;
        break;
      case 'nature':
        if (pole == 'THINKING') scoreT += score;
        if (pole == 'FEELING') scoreF += score;
        break;
      case 'tactics':
        if (pole == 'JUDGING') scoreJ += score;
        if (pole == 'PROSPECTING') scoreP += score;
        break;
      case 'identity':
        if (pole == 'ASSERTIVE') scoreA += score;
        if (pole == 'TURBULENT') scoreTurb += score;
        break;
    }
  }

  // Determine letters for each dimension
  String ei = scoreE >= scoreI ? 'E' : 'I';
  String sn = scoreN >= scoreS ? 'N' : 'S';
  String tf = scoreT >= scoreF ? 'T' : 'F';
  String jp = scoreJ >= scoreP ? 'J' : 'P';
  String identity = scoreA >= scoreTurb ? '-A' : '-T';
  final type = '$ei$sn$tf$jp$identity';

  // Calculate percentages for each dimension
  int pct(int a, int b) {
    final total = (a.abs() + b.abs());
    if (total == 0) return 50;
    return ((a.abs() / total) * 100).round();
  }

  return TestResult(
    type: type,
    rawEI: scoreE - scoreI,
    rawSN: scoreN - scoreS,
    rawTF: scoreT - scoreF,
    rawJP: scoreJ - scoreP,
    eiPct: pct(scoreE, scoreI),
    snPct: pct(scoreN, scoreS),
    tfPct: pct(scoreT, scoreF),
    jpPct: pct(scoreJ, scoreP),
  );
}
