import 'package:football_fever/backend/api_header.dart';
import 'package:football_fever/common/model/match_prediction_res.dart';
import 'package:football_fever/common/model/match_res.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:get/get.dart';

import '../../../backend/api_client.dart';
import '../../../backend/api_endpoints.dart';
import '../../../common/model/season_match_res.dart';
import '../../../common/model/team_model_res.dart';

class MatchController extends GetxController {
  List<String> matchDetailsTab = [
    'Rounds',
    'Preview',
    'Stats',
    'Lineup',
    'Event',
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
  Future<SeasonMatchRes?> getFixtureByFixtureData(String seasonId,
      {Map<String, dynamic>? params}) async {
    logPrint(
      '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getFixtureSeasonIdsUrl}$seasonId',
    );
    await ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.getFixtureSeasonIdsUrl}$seasonId',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: params ??
          {
            'filters': 'fixtureStates:1',
            'include':
                "fixtures.participants;fixtures.scores;fixtures.periods;topscorers.player.country"
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

//get match fixture by id
  Future<MatchModel?> getFixtureByFixtureId(String id,
      {String? include}) async {
    MatchModel? matchModel;
    await ApiClient.remoteApiCall(
      apiUrl: '${APIEndpoints.sportsBaseUrl}${APIEndpoints.fixturesUrl}$id',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: {
        'include': include ?? "lineups;formations;lineups.player;coaches"
      },
      ifLoading: () {},
      ifSucceed: (response) {
        try {
          logPrint(
              '${APIEndpoints.sportsBaseUrl}${APIEndpoints.fixturesUrl}$id');
          Map<String, dynamic> serverMap = response.data;
          matchModel = MatchModel.fromJson(serverMap['data']);
        } catch (e) {
          return null;
        }
      },
      ifFailed: (error) {
        return null;
      },
    );
    return matchModel;
  }
}
