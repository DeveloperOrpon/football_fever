import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/match_res.dart';

class LocalAppData {
  static Future<List<Participant>> getFavoriteTeam() async {
    final localBD = await SharedPreferences.getInstance();
    String? savedStringJSON = localBD.getString('FavoriteTeam');
    if (savedStringJSON == null) {
      return [];
    }
    List<dynamic> savedJSON = json.decode(savedStringJSON);
    List<Participant> tempFavTeam = [];
    for (var json in savedJSON) {
      tempFavTeam.add(Participant.fromJson(json));
    }
    return tempFavTeam;
  }

  //save favorite team
  static Future setFavoriteTeam(List<Participant> favoriteTeamList) async {
    final localBD = await SharedPreferences.getInstance();
    List<Map> tempFavMap = [];
    for (Participant team in favoriteTeamList) {
      tempFavMap.add(team.toJson());
    }
    String jsonString = json.encode(tempFavMap);
    bool result = await localBD.setString('FavoriteTeam', jsonString);
    return result;
  }

//get FavoriteLeague
  static Future<List<League>> getFavoriteLeague() async {
    final localBD = await SharedPreferences.getInstance();
    String? savedStringJSON = localBD.getString('FavoriteLeague');
    if (savedStringJSON == null) {
      return [];
    }
    List<dynamic> savedJSON = json.decode(savedStringJSON);
    List<League> tempFavLeague = [];
    for (var json in savedJSON) {
      tempFavLeague.add(League.fromJson(json));
    }
    return tempFavLeague;
  }

  //save favorite team
  static Future setFavoriteLeague(List<League> favoriteLeagueList) async {
    final localBD = await SharedPreferences.getInstance();
    List<Map> leagueFavMap = [];
    for (League team in favoriteLeagueList) {
      leagueFavMap.add(team.toJson());
    }
    String jsonString = json.encode(leagueFavMap);
    bool result = await localBD.setString('FavoriteLeague', jsonString);
    return result;
  }
}
