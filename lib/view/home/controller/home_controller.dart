import 'package:flutter/material.dart';
import 'package:football_fever/backend/api_client.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_endpoints.dart';
import '../../../common/model/match_res.dart';
import '../../../utils/helper/helper_method.dart';

class HomeController extends GetxController {
  RxInt homeBottomIndex = RxInt(0);
  PageController pageController = PageController(initialPage: 0);
  @override
  onInit() {
    super.onInit();
    getDateWaysMatch(date: fixtureDateFormateQuery(DateTime.now()));
  }

  //todayMatch
  RefreshController refreshControllerAllScore =
      RefreshController(initialRefresh: false);

  void onRefreshAllScore() async {
    _currentDate = DateTime.now();
    scorePageLoading.value = true;
    homeAllDateWaysMatchesList.clear();
    await getDateWaysMatch(date: fixtureDateFormateQuery(_currentDate));
    refreshControllerAllScore.refreshCompleted();
  }

  void onLoadingAllScore() async {
    _incrementDate();
    if (!scoreOnLoadCalling.value) {
      scoreOnLoadCalling.value = true;
      await getDateWaysMatch(date: fixtureDateFormateQuery(_currentDate));
    }
    refreshControllerAllScore.loadComplete();
  }

  DateTime _currentDate = DateTime.now();
  void _incrementDate() {
    _currentDate = _currentDate.add(const Duration(days: 1));
  }

  RxBool scorePageLoading = RxBool(true);
  RxBool scoreOnLoadCalling = RxBool(false);

  RxMap<String, Map<String, List<MatchModel>>> homeAllDateWaysMatchesList =
      RxMap();
  Future<void> getDateWaysMatch({required String date}) async {
    RxMap<String, List<MatchModel>> homeDateWaysMatches = RxMap();
    return ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.fixturesUrl}date/$date',
      reqType: ApiRequestType.get,
      headers: {
        "token": APIEndpoints.cacheServerApiToken,
      },
      queryParameters: {
        'include': 'participants;scores;league.seasons;events.participant'
      },
      ifLoading: () {
        homeDateWaysMatches.clear();
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        MatchRes tempRes = MatchRes.fromJson(serverMap);
        (tempRes.data ?? [])
            .sort((a, b) => a.league!.name!.compareTo(b.league!.name!));
        homeDateWaysMatches.value = {};
        for (var match in (tempRes.data ?? [])) {
          homeDateWaysMatches.putIfAbsent(
              match.league!.name.toString(), () => []);
          homeDateWaysMatches[match.league!.name.toString()]!.add(match);
        }
        scorePageLoading.value = false;
        scoreOnLoadCalling.value = false;
        homeAllDateWaysMatchesList.putIfAbsent(date, () => homeDateWaysMatches);
        logPrint('susses: ${homeDateWaysMatches.length}');
        return;
      },
      ifFailed: (error) {
        logPrint('error: ${error.message}');
        scorePageLoading.value = false;
        scoreOnLoadCalling.value = false;
        homeDateWaysMatches.clear();
        return;
      },
    );
  }

  RxMap<String, List<MatchModel>> dayAllDateWaysMatches = RxMap();
  RxBool allDayMatchLoading = RxBool(false);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  void onRefreshDayAllMatches(String date) async {
    page = 1;
    dayAllDateWaysMatches.value = {};

    getDateWaysMatchPagination(
        date: date.toLowerCase() == "TODAY".toLowerCase()
            ? fixtureDateFormateQuery(DateTime.now())
            : date,
        page: page);
    refreshController.refreshCompleted();
  }

  void onLoadingDayAllMatches(String date) async {
    page++;
    logPrint(
        '${APIEndpoints.sportsBaseUrl}${APIEndpoints.fixturesUrl}date/$date?page=$page');

    getDateWaysMatchPagination(
        date: date.toLowerCase() == "TODAY".toLowerCase()
            ? fixtureDateFormateQuery(DateTime.now())
            : date,
        page: page);
  }

  Future<Map<String, List<MatchModel>>> getDateWaysMatchPagination({
    required String date,
    required int page,
  }) async {
    return ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.fixturesUrl}date/$date',
      reqType: ApiRequestType.get,
      headers: {
        "token": APIEndpoints.cacheServerApiToken,
      },
      ifLoading: () {
        if (page == 1) {
          allDayMatchLoading.value = true;
        }
      },
      queryParameters: {
        'include': 'participants;scores;league.seasons;events.participant',
        "page": page,
      },
      ifSucceed: (response) {
        logPrint(
            'Url: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        Map<String, dynamic> serverMap = response.data;
        MatchRes tempRes = MatchRes.fromJson(serverMap);
        (tempRes.data ?? [])
            .sort((a, b) => a.league!.name!.compareTo(b.league!.name!));
        if (page == 1) {
          dayAllDateWaysMatches.value = {};
          for (var match in (tempRes.data ?? [])) {
            dayAllDateWaysMatches.putIfAbsent(
                match.league!.name.toString(), () => []);
            dayAllDateWaysMatches[match.league!.name.toString()]!.add(match);
          }
          logPrint('${dayAllDateWaysMatches.length}');
          allDayMatchLoading.value = false;
        } else {
          logPrint('load_$page--${(tempRes.data ?? []).length}');

          for (var match in (tempRes.data ?? [])) {
            logPrint("load_${match.league!.name}");
            dayAllDateWaysMatches.putIfAbsent(
                "${match.league!.name}.", () => []);
            dayAllDateWaysMatches["${match.league!.name}."]!.add(match);
          }
          logPrint('load_${dayAllDateWaysMatches.length}');
          refreshController.loadComplete();
        }

        return dayAllDateWaysMatches;
      },
      ifFailed: (error) {
        allDayMatchLoading.value = false;
        logPrint("${error.message}");
        return {};
      },
    );
  }

  ///live matches
  RxBool isLiveScoreMatch = RxBool(false);
  Rxn<MatchRes> liveMatchRes = Rxn<MatchRes>();
  RxList<MatchModel> liveMatchList = RxList<MatchModel>([]);

  getScoreLiveMatches() async {
    return ApiClient.remoteApiCall(
      apiUrl: '${APIEndpoints.sportsBaseUrl}${APIEndpoints.liveScoresUrl}',
      reqType: ApiRequestType.get,
      headers: {
        "token": APIEndpoints.cacheServerApiToken,
      },
      queryParameters: {
        'include': 'participants;scores;league.seasons;events.participant'
      },
      ifLoading: () {
        isLiveScoreMatch.value = true;
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        liveMatchRes.value = MatchRes.fromJson(serverMap);
        liveMatchList.value = liveMatchRes.value!.data ?? [];
        isLiveScoreMatch.value = false;
      },
      ifFailed: (error) {
        isLiveScoreMatch.value = false;
      },
    );
  }

  //liveMatches refresh
  RefreshController refreshControllerLiveMatches =
      RefreshController(initialRefresh: false);

  void onRefreshLiveMatches() async {
    isLiveScoreMatch.value = true;
    getScoreLiveMatches();
    refreshControllerLiveMatches.refreshCompleted();
  }

  void onLoadingLiveMatches() async {
    refreshControllerLiveMatches.loadComplete();
  }
}
