import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../../common/model/match_res.dart';
import '../../common/model/season_match_res.dart';

String fixtureDateFormateQuery(DateTime dateTime) {
  String date = DateFormat('yyyy-MM-dd').format(dateTime);
  return date;
}

Participant? getHomeTeam(List<Participant> participants) {
  Participant participant = participants
      .firstWhere((element) => element.meta!.location == Location.HOME);
  return participant;
}

Participant? getAwayTeam(List<Participant> participants) {
  Participant participant = participants
      .firstWhere((element) => element.meta!.location == Location.AWAY);
  return participant;
}

String getMatchTimeFormate(int timestamp) {
  int millisecondsSinceEpoch = timestamp * 1000;
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}

DateTime timeStampDate(int timestamp) {
  int millisecondsSinceEpoch = timestamp * 1000;
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  return dateTime;
}

String getMatchDateFormate(int timestamp) {
  int millisecondsSinceEpoch = timestamp * 1000;
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedTime = DateFormat('EEE, d MMM').format(dateTime);
  return formattedTime;
}

String dateWayMatchCount(Map<String, List<MatchModel>> map) {
  int matchCount = 0;
  map.forEach((key, matchList) {
    matchCount += matchList.length;
  });
  return matchCount.toString();
}

String getMatchResult(List<ScoreElement> scores) {
  String result = '';
  List<ScoreElement> currentScores = scores
      .where((element) => element.description == Description.CURRENT)
      .toList();
  result =
      '$result${currentScores.firstWhereOrNull((element) => element.score!.participant == Location.HOME)!.score!.goals} - ';
  result =
      '$result${currentScores.firstWhereOrNull((element) => element.score!.participant == Location.AWAY)!.score!.goals}';
  return result;
}

String timestampToDateFormate(int timestamp, {String formate = 'ha d MMMM'}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate = DateFormat(formate).format(date);
  return formattedDate;
}

String secondToTimeDef(String s) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      (num.parse(s.toString()) * 1000).toInt());
  return DateTime.now().difference(dateTime).inHours.toString();
}

RegExp htmlExp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
String getTimeStampParse(int timestamp) {
  int millisecondsSinceEpoch = timestamp * 1000;
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}

int probabilityCalculate(String probabilityString) {
  double probabilityDouble =
      double.parse(probabilityString.replaceAll('%', ''));
  int probabilityInt = probabilityDouble.round();
  return probabilityInt;
}

String getPositionName(int positionId) {
  switch (positionId) {
    case 24:
      return 'Goalkeeper';
    case 25:
      return 'Defender';
    case 26:
      return 'Midfielder';
    case 27:
      return 'Attacker';
    case 28:
      return 'Unknown';
    case 148:
      return 'Centre Back';
    case 149:
      return 'Defensive Midfield';
    case 150:
      return 'Attacking Midfield';
    case 151:
      return 'Centre Forward';
    case 152:
      return 'Left Wing';
    case 153:
      return 'Central Midfield';
    case 154:
      return 'Right Back';
    case 155:
      return 'Left Back';
    case 156:
      return 'Right Wing';
    case 157:
      return 'Left Midfield';
    case 158:
      return 'Right Midfield';
    case 163:
      return 'Secondary Striker';
    case 221:
      return 'Coach';
    case 226:
      return 'Assistant Coach';
    case 227:
      return 'Goalkeeping Coach';
    case 228:
      return 'Forward Coach';
    case 560:
      return 'Caretaker Manager';
    default:
      return 'Unknown';
  }
}

List<TopScorer> removeDuplicateElement(List<TopScorer> topScorer) {
  final set = <TopScorer>{};
  for (var scorer in topScorer) {
    set.add(scorer);
  }
  return set.toList();
}

String getStatusName(int positionId) {
  switch (positionId) {
    case 34:
      return 'Corners';
    case 40:
      return 'Captain';
    case 41:
      return 'Shots Off Target';
    case 42:
      return 'Shots Total';
    case 43:
      return 'Attacks';
    case 44:
      return 'Dangerous Attacks';
    case 45:
      return 'Ball Possession';
    case 46:
      return 'Ball Safe';
    case 47:
      return 'Penalties';
    case 49:
      return 'Shots Inside Box';
    case 50:
      return 'Shots Outside Box';
    case 51:
      return 'Offsides';
    case 52:
      return 'Goals';
    case 53:
      return 'Goals Kicks';
    case 54:
      return 'Goal Attempts';
    case 55:
      return 'Free Kicks';
    case 56:
      return 'Fouls';
    case 57:
      return 'Saves';
    case 58:
      return 'Shots Blocked';
    case 59:
      return 'Substitutions';
    case 60:
      return 'Throwins';
    case 61:
      return 'Beats';
    case 62:
      return 'Long Passes';
    case 63:
      return 'Short Passes';
    case 64:
      return 'Hit Woodwork';
    case 65:
      return 'Successful Headers';
    case 66:
      return 'Successful Interceptions';
    case 70:
      return 'Headers';
    case 72:
      return 'First Substitution';
    case 76:
      return 'Goalkeeper Comes Out';
    case 77:
      return 'Challenges';
    case 78:
      return 'Tackles';
    case 79:
      return 'Assists';
    case 80:
      return 'Passes';
    case 81:
      return 'Successful Passes';
    case 82:
      return 'Successful Passes Percentage';
    case 83:
      return 'Red Cards';
    case 84:
      return 'Yellow Cards';
    case 85:
      return 'Yellow-Red Cards';
    case 86:
      return 'Shots On Target';
    case 87:
      return 'Injuries';
    case 88:
      return 'Goals Conceded';
    case 91:
      return 'Last Offside';
    case 92:
      return 'First Offside';
    case 94:
      return 'Dispossessed';
    case 95:
      return 'Offsides Provoked';
    case 96:
      return 'Fouls Drawn';
    case 97:
      return 'Blocked Shots';
    case 98:
      return 'Total Crosses';
    case 99:
      return 'Accurate Crosses';
    case 100:
      return 'Interceptions';
    case 101:
      return 'Clearances';
    case 103:
      return 'Punches';
    case 104:
      return 'Saves Inside Box';
    case 105:
      return 'Total Duels';
    case 106:
      return 'Duels Won';
    case 107:
      return 'Aerials Won';
    case 108:
      return 'Dribble Attempts';
    case 109:
      return 'Successful Dribbles';
    case 110:
      return 'Dribbled Past';
    case 111:
      return 'Penalties Scored';
    case 112:
      return 'Penalties Missed';
    case 113:
      return 'Penalties Saved';
    case 114:
      return 'Penalties Committed';
    case 115:
      return 'Penalties Won';
    case 116:
      return 'Accurate Passes';
    case 117:
      return 'Key Passes';
    case 118:
      return 'Rating';
    case 119:
      return 'Minutes Played';
    case 120:
      return 'Touches';
    case 121:
      return 'Turn Over';
    case 122:
      return 'Long Balls';
    case 123:
      return 'Long Balls Won';
    case 124:
      return 'Through Balls';
    case 125:
      return 'Through Balls Won';
    case 188:
      return 'Matches';
    case 189:
      return 'Total Teams';
    case 190:
      return 'Matches Ended in Draw';
    case 191:
      return 'Number of Goals';
    case 192:
      return 'BTTS';
    case 193:
      return 'Cards';
    case 194:
      return 'Cleansheets';
    case 195:
      return 'Goalkeeper Cleansheets';
    case 196:
      return 'Scoring Minutes';
    case 197:
      return 'Goal Line';
    case 201:
      return 'Win Percentage';
    case 202:
      return 'Defeat Percentage';
    case 203:
      return 'Draw Percentage';
    case 204:
      return 'Participant Most Scored';
    case 205:
      return 'Participant Most Conceded';
    case 206:
      return 'Participant Most Scored Per Match';
    case 207:
      return 'Participant Most Conceded Per Match';
    case 208:
      return 'Goal Topscorer';
    case 209:
      return 'Assist Topscorer';
    case 210:
      return 'Card Topscorer';
    case 1600:
      return 'Penalty Topscorer';
    case 1601:
      return 'Missed Penalty Topscorer';
    case 211:
      return 'Highest Rated Player';
    case 212:
      return 'Highest Rated Team';
    case 213:
      return 'Conceded Scoring Minutes';
    case 214:
      return 'Team Wins';
    case 215:
      return 'Team Draws';
    case 216:
      return 'Team Lost';
    case 314:
      return 'VAR Moments';
    case 321:
      return 'Appearances';
    case 322:
      return 'Lineups';
    case 323:
      return 'Bench';
    case 324:
      return 'Own Goals';
    case 571:
      return 'Error Lead to Goal';
    case 574:
      return 'Referees';
    case 1527:
      return 'Counter Attacks';
    case 1535:
      return 'Goalkeeper Goals Conceded';
    case 9683:
      return 'Cards Per Foul';
    case 9682:
      return 'Shot On Target Percentage';
    case 9681:
      return 'Shot Conversion Rate';
    case 9680:
      return 'Penalty Conversion Rate';
    case 9679:
      return 'Most Injured Players';
    case 9678:
      return 'Most Substituted Players';
    case 9677:
      return 'Appearing Players';
    case 9676:
      return 'Average Points Per Game';
    case 9675:
      return 'Players Footing';
    case 9674:
      return 'Amount of Foreigners';
    case 9673:
      return 'Average Player Age';
    default:
      return 'Unknown';
  }
}
