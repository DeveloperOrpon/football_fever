import 'package:football_fever/backend/api_header.dart';
import 'package:football_fever/common/model/match_prediction_res.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:get/get.dart';

import '../../../backend/api_client.dart';
import '../../../backend/api_endpoints.dart';
import '../../../common/model/season_match_res.dart';
import '../../../common/model/team_model_res.dart';

class MatchController extends GetxController {
  List<String> matchDetailsTab = [
    'Rounds',
    'Previous',
    'Stats',
    'Lineup',
    'Commentary'
  ];
  MatchPredictionRes? matchPredictionRes;
  Future<MatchPredictionRes?> getMatchPredictionByMatchId(
      String featureId) async {
    logPrint(
        '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getMatchPredictionUrl}$featureId');
    await ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getMatchPredictionUrl}$featureId',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: {'filters': 'bookmakers:14'},
      ifLoading: () {},
      ifSucceed: (response) {
        try {
          Map<String, dynamic> serverMap = response.data;
          if (serverMap['message'] != null) {
            matchPredictionRes = null;
          } else {
            matchPredictionRes = MatchPredictionRes.fromJson(serverMap);
            return matchPredictionRes;
          }
        } catch (e) {
          return null;
        }
      },
      ifFailed: (error) {
        return null;
      },
    );
    return matchPredictionRes;
  }

//get season match by season
  SeasonMatchRes? seasonMatchRes;
  Future<SeasonMatchRes?> getFixtureByFixtureData(String seasonId) async {
    logPrint(
      '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getFixtureSeasonIdsUrl}$seasonId',
    );
    await ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getFixtureSeasonIdsUrl}$seasonId',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: {
        'filters': 'fixtureStates:1',
        'include': "fixtures.participants;fixtures.scores;fixtures.periods"
      },
      ifLoading: () {},
      ifSucceed: (response) {
        try {
          Map<String, dynamic> serverMap = response.data;
          seasonMatchRes = SeasonMatchRes.fromJson(serverMap);
        } catch (e) {
          return null;
        }
      },
      ifFailed: (error) {
        return null;
      },
    );
    return seasonMatchRes;
  }

// get team information
  TeamModelRes? teamModelRes;
  Future<TeamModelRes?> getTeamInfo(String teamId) async {
    await ApiClient.remoteApiCall(
      apiUrl: '${APIEndpoints.sportsBaseUrl}${APIEndpoints.teamUrl}/$teamId',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: {
        'include': "country;latest.participants;latest.scores;latest.periods"
      },
      ifLoading: () {},
      ifSucceed: (response) {
        try {
          Map<String, dynamic> serverMap = response.data;
          teamModelRes = TeamModelRes.fromJson(serverMap);
        } catch (e) {
          return null;
        }
      },
      ifFailed: (error) {
        return null;
      },
    );
    return teamModelRes;
  }
}
