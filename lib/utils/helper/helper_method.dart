import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../../common/model/match_res.dart';

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
      '$result${currentScores.firstWhereOrNull((element) => element.score!.participant == Location.HOME)!.score!.goals} : ';
  result =
      '$result${currentScores.firstWhereOrNull((element) => element.score!.participant == Location.AWAY)!.score!.goals}';
  return result;
}

String timestampToDateFormate(int timestamp, {String formate = 'ha d MMMM'}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate = DateFormat(formate).format(date);
  return formattedDate;
}
