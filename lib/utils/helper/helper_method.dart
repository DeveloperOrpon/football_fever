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
