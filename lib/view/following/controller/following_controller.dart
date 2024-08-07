import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_fever/backend/api_header.dart';
import 'package:football_fever/common/model/league_res.dart';
import 'package:football_fever/common/shared_preferences/local_app_data.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_client.dart';
import '../../../backend/api_endpoints.dart';
import '../../../common/model/match_res.dart';
import '../../../common/model/search_team_res.dart';
import '../../../common/model/team_res.dart';

class FollowingController extends GetxController {
  @override
  void onInit() {
    getLocalDataTeam(isInit: true);
    getLocalDataLeague(isInit: true);
    super.onInit();
  }

  //load all teams information with pagination
  RxBool isTeamLoading = RxBool(false);
  Rxn<TeamRes> tempRes = Rxn<TeamRes>();
  RxList<Participant> allTeamList = RxList([]);
  getAllTeams() {
    return ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.teamUrl}?page=$pageTeam',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      ifLoading: () {
        if (pageTeam == 1) {
          isTeamLoading.value = true;
        }
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        if (serverMap['data'] == null) {
          isTeamLoading.value = false;
          refreshControllerTeam.loadComplete();
          refreshControllerTeam.refreshCompleted();
          refreshControllerTeamPopUp.refreshCompleted();
        } else {
          tempRes.value = TeamRes.fromJson(serverMap);
          if (pageTeam == 1) {
            allTeamList.value = tempRes.value!.data ?? [];
            logPrint('TeamRes: ${allTeamList.length}');
          } else {
            List<Participant> tempTeamList = [];
            tempTeamList = allTeamList.value;
            tempTeamList.addAll(tempRes.value!.data ?? []);
            allTeamList.value = [];
            allTeamList.value = tempTeamList;
            refreshControllerTeam.loadComplete();
            refreshControllerTeamPopUp.loadComplete();
          }
          isTeamLoading.value = false;
        }
      },
      ifFailed: (error) {
        logPrint('TeamRes: ${error.message}');
        isTeamLoading.value = false;
      },
    );
  }

  //user favorite teams
  RxBool isFavoriteTeamLoading = RxBool(false);
  RxList<Participant> favoriteTeamList = RxList([]);
  RefreshController refreshControllerTeam =
      RefreshController(initialRefresh: false);
  int pageTeam = 1;
  void onRefreshTeam() async {
    pageTeam = 1;
    getAllTeams();
    refreshControllerTeam.refreshCompleted();
  }

  void onLoadingTeam() async {
    pageTeam++;
    getAllTeams();
  }

  RefreshController refreshControllerTeamPopUp =
      RefreshController(initialRefresh: false);
  void onRefreshTeamPopUp() async {
    pageTeam = 1;
    getAllTeams();
    refreshControllerTeamPopUp.refreshCompleted();
  }

  void onLoadingTeamPopUp() async {
    pageTeam++;
    getAllTeams();
  }

  //
  //load all league information with pagination
  RxBool isLeagueLoading = RxBool(false);
  Rxn<LeagueRes> leagueRes = Rxn<LeagueRes>();
  RxList<League> allLeagueList = RxList<League>([]);
  getAllLeagues() {
    return ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.leagueUrl}?page=$pageLeague',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      ifLoading: () {
        if (pageLeague == 1) {
          isLeagueLoading.value = true;
        }
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        if (serverMap['data'] == null) {
          isLeagueLoading.value = false;
          refreshControllerLeague.loadComplete();
          refreshControllerLeaguePopUp.loadComplete();
        } else {
          if (pageLeague == 1) {
            leagueRes.value = LeagueRes.fromJson(serverMap);
            allLeagueList.value = leagueRes.value!.data ?? [];
            logPrint('allLeagueList: ${allTeamList.length}');
            isLeagueLoading.value = false;
          } else {
            leagueRes.value = LeagueRes.fromJson(serverMap);
            List<League> tempLeagueList = [];
            tempLeagueList = allLeagueList.value;
            tempLeagueList.addAll(leagueRes.value!.data ?? []);
            allLeagueList.value = [];
            allLeagueList.value = tempLeagueList;
            refreshControllerLeague.loadComplete();
            refreshControllerLeaguePopUp.loadComplete();
          }
        }
      },
      ifFailed: (error) {
        logPrint('allLeagueList: ${error.message}');
        isLeagueLoading.value = false;
      },
    );
  }

  saveFavoriteTeam(Participant team) {
    if (favoriteTeamList.firstWhereOrNull((e) => e.id == team.id) == null
        ? false
        : true) {
      favoriteTeamList.removeWhere((e) => e.id == team.id);
    } else {
      favoriteTeamList.add(team);
    }
    getLocalDataTeam();
  }

  getLocalDataTeam({bool isInit = false}) async {
    if (!isInit) await LocalAppData.setFavoriteTeam(favoriteTeamList);
    await LocalAppData.getFavoriteTeam().then((value) {
      favoriteTeamList.value = value;
    });
  }

  //user favorite teams
  RxBool isFavoriteLeagueLoading = RxBool(false);
  RxList<League> favoriteLeagueList = RxList<League>([]);
  RefreshController refreshControllerLeague =
      RefreshController(initialRefresh: false);
  int pageLeague = 1;
  void onRefreshLeague() async {
    pageLeague = 1;
    getAllLeagues();
    refreshControllerLeague.refreshCompleted();
  }

  void onLoadingLeague() async {
    pageLeague++;
    getAllLeagues();
  }

  RefreshController refreshControllerLeaguePopUp =
      RefreshController(initialRefresh: false);
  void onRefreshLeaguePopUp() async {
    pageLeague = 1;
    getAllLeagues();
    refreshControllerLeaguePopUp.refreshCompleted();
  }

  void onLoadingLeaguePopUp() async {
    pageLeague++;
    getAllLeagues();
  }

// Save user favorite team
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  // Save user favorite team
  saveFavoriteLeague(League league) {
    if (favoriteLeagueList.firstWhereOrNull((e) => e.id == league.id) == null
        ? false
        : true) {
      favoriteLeagueList.removeWhere((e) => e.id == league.id);
    } else {
      favoriteLeagueList.add(league);
    }
    getLocalDataLeague();
  }

  getLocalDataLeague({bool isInit = false}) async {
    if (!isInit) await LocalAppData.setFavoriteLeague(favoriteLeagueList);
    await LocalAppData.getFavoriteLeague().then((value) {
      favoriteLeagueList.value = value;
    });
  }

  //
  RxList<Participant> availableSearchTeam = RxList<Participant>([]);
  RxBool isSearchLoading = RxBool(false);
  Future<void> teamSearch(String query) async {
    return ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.searchTeamUrl}$query',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      queryParameters: {
        'include': 'activeSeasons.league.country;activeSeasons.league.seasons',
      },
      ifLoading: () {
        isSearchLoading.value = true;
        availableSearchTeam.clear();
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        SearchTeamRes searchTeamRes = SearchTeamRes.fromJson(serverMap);
        availableSearchTeam.value = searchTeamRes.data ?? [];
        isSearchLoading.value = false;
      },
      ifFailed: (error) {
        isSearchLoading.value = false;
      },
    );
  }
}
