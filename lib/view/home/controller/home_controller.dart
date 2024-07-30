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
  int page = 2;
  void onRefresh(String date) async {
    page = 1;
    dayAllDateWaysMatches.value = {};

    await getDateWaysMatchPagination(
        date: date.toLowerCase() == "TODAY".toLowerCase()
            ? fixtureDateFormateQuery(DateTime.now())
            : date,
        page: page);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadComplete();
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
        allDayMatchLoading.value = true;
      },
      queryParameters: {
        'include': 'participants;scores;league.seasons;events.participant',
        "page": page,
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        MatchRes tempRes = MatchRes.fromJson(serverMap);
        (tempRes.data ?? [])
            .sort((a, b) => a.league!.name!.compareTo(b.league!.name!));
        dayAllDateWaysMatches.value = {};
        for (var match in (tempRes.data ?? [])) {
          dayAllDateWaysMatches.putIfAbsent(
              match.league!.name.toString(), () => []);
          dayAllDateWaysMatches[match.league!.name.toString()]!.add(match);
        }
        logPrint('${dayAllDateWaysMatches.length}');
        allDayMatchLoading.value = false;
        return dayAllDateWaysMatches;
      },
      ifFailed: (error) {
        allDayMatchLoading.value = false;
        logPrint("${error.message}");
        return {};
      },
    );
  }
}
