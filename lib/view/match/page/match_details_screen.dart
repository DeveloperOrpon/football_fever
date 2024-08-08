import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/team_model_res.dart';
import 'package:football_fever/common/widget/match_score_widget.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:football_fever/view/match/tabs/comment_tab.dart';
import 'package:football_fever/view/match/tabs/lineup_tab.dart';
import 'package:football_fever/view/match/tabs/rounds_tab.dart';
import 'package:football_fever/view/match/tabs/stats_tab.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/model/match_prediction_res.dart';
import '../../../common/model/match_res.dart';
import '../../../common/model/season_match_res.dart';
import '../../../common/widget/net_image.dart';
import '../../../utils/helper/helper_method.dart';
import '../controller/match_controller.dart';
import '../tabs/event_tab.dart';
import '../tabs/previous_tab.dart';

class MatchDetailsScreen extends StatefulWidget {
  final MatchModel matchModel;
  const MatchDetailsScreen({super.key, required this.matchModel});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  MatchPredictionRes? matchPredictionRes;
  TeamModelRes? homeTeamInformation;
  TeamModelRes? awayTeamInformation;
  List<MatchModel> leagueMatches = [];
  final MatchController matchController = Get.find();
  bool isLoading = false;
  bool isLoadingRound = true;
  // season list
  SeasonMatchRes? seasonMatchRes;
  Map<String, List<TopScorer>> leagueWaysTopPlayerState = {};
  List<TopScorer> topScore = [];
  List<TopScorer> topAssists = [];
  List<TopScorer> topRedCards = [];
  List<TopScorer> topYellowCards = [];
  // player formation line up value

  bool isLoadingLineUp = true;

  MatchModel? lineUpMatchModel;
  //totalStatistics
  bool isLoadingState = true;
  Map<String, List<Statistic>> totalStatistics = {};
  MatchModel? statisticsMatchModel;
  List<List<Lineup>> homeLineup = [];
  List<List<Lineup>> awayLineup = [];
  Map<int?, List<Lineup>> lineupSorted = {};
  List<Formation> fixtureFormations = [];
  Map<int?, List<Formation>> formationGroupBy = <int?, List<Formation>>{};
  List<Lineup> fixtureLineup = <Lineup>[];
  //end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
            ),
          )
        ],
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetImageView(
              type: 'league',
              url: '${widget.matchModel.league!.imagePath}',
              height: 20.h,
              fit: BoxFit.contain,
            ),
            4.horizontalSpace,
            Text(
              textAlign: TextAlign.left,
              '${widget.matchModel.league!.name}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
            ),
          ],
        ),
        bottom: isLoading
            ? PreferredSize(
                preferredSize: Size.fromHeight(1.h),
                child: LinearProgressIndicator(
                  minHeight: 2,
                  color: Get.theme.primaryColor,
                ),
              )
            : null,
      ),
      body: DefaultTabController(
        length: matchController.matchDetailsTab.length,
        child: Column(
          children: [
            MatchScoreCustomWidget(
              matchModel: widget.matchModel,
              onTap: getMatchPredictionByMatchId,
              matchPredictionRes: matchPredictionRes,
            ),
            TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Get.theme.primaryColor,
              indicatorWeight: 1,
              labelStyle: Get.theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Get.width > 600 ? 14.sp : null,
              ),
              unselectedLabelStyle: Get.theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: Get.theme.disabledColor,
                fontSize: Get.width > 600 ? 14.sp : null,
              ),
              tabs: matchController.matchDetailsTab.map((e) {
                return Tab(
                  text: e.toUpperCase(),
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RoundsTab(
                    isLoading: isLoadingRound,
                    matchModel: widget.matchModel,
                    leagueLastMatches: leagueMatches,
                    onInit: getSeasonWayMatchList,
                  ),
                  PreviousTab(
                    matchModel: widget.matchModel,
                    topAssists: topAssists,
                    topScore: topScore,
                    awayTeamInfo: awayTeamInformation,
                    homeTeamInfo: homeTeamInformation,
                    onInit: () {
                      getTeamByTeamId();
                      awayTeamByTeamId();
                    },
                  ),
                  StatsTab(
                    isLoadingStats: isLoadingState,
                    totalStatistics: totalStatistics,
                    onInit: getStatistics,
                  ),
                  LineupTab(
                    matchModel: widget.matchModel,
                    lineUpMatchModel: lineUpMatchModel,
                    onInit: getLineUpInformation,
                    awayLineup: awayLineup,
                    homeLineup: homeLineup,
                  ),
                  EventTab(),
                  CommentTab()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getMatchPredictionByMatchId() {
    if (matchPredictionRes == null) {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoading = true;
        });
      });
      matchController
          .getMatchPredictionByMatchId(widget.matchModel.id.toString())
          .then((value) {
        setState(() {
          isLoading = false;
          matchPredictionRes = value;
        });
        logPrint('getMatchPredictionByMatchId :${value?.data?.length}');
      });
    }
  }

  getSeasonWayMatchList() async {
    if (seasonMatchRes == null) {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoadingRound = true;
        });
      });
      matchController
          .getFixtureByFixtureData(widget.matchModel.seasonId.toString())
          .then((value) {
        seasonMatchRes = value;
        logPrint('value:${value?.data?.topscorers?.length}');
        for (MatchModel match in (value?.data?.fixtures ?? [])) {
          String time = DateFormat("dd MMM yyyy")
              .format(timeStampDate(match.startingAtTimestamp!));
          String selectMatchTime = DateFormat("dd MMM yyyy")
              .format(timeStampDate(widget.matchModel.startingAtTimestamp!));

          if (time == selectMatchTime) {
            leagueMatches.add(match);
          }
        }
        isLoadingRound = false;
        setState(() {});
        intSeasonScoreList();
      });
    }
  }

  intSeasonScoreList() {
    for (var element in seasonMatchRes!.data!.topscorers!) {
      logPrint("leagueWaysTopPlayerState:  ${element.typeId}");

      leagueWaysTopPlayerState.putIfAbsent(element.typeId.toString(), () => []);
      if (!leagueWaysTopPlayerState[element.typeId.toString()]!
          .contains(element)) {
        leagueWaysTopPlayerState[element.typeId.toString()]!.add(element);
      }
    }
    leagueWaysTopPlayerState.forEach((key, value) {
      value.sort((a, b) => a.position!
          .compareTo(b.position!)); // Sort based on score in ascending order
    });
    logPrint("leagueWaysTopPlayerState:  ${leagueWaysTopPlayerState.length}");
    topScore = removeDuplicateElement(
        ((leagueWaysTopPlayerState['208']) ?? []).toList());
    topAssists = removeDuplicateElement(
        ((leagueWaysTopPlayerState['209']) ?? []).toList());
    // topYellowCards = removeDuplicateElement(
    //     ((leagueWaysTopPlayerState[Name.YELLOWCARDS.toString()]) ?? [])
    //         .toList());
    // topRedCards = removeDuplicateElement(
    //     ((leagueWaysTopPlayerState[Name.REDCARDS.toString()]) ?? []).toList());
  }

  getTeamByTeamId() async {
    if (homeTeamInformation == null) {
      matchController
          .getTeamInfo(widget.matchModel.participants![0].id.toString())
          .then((value) {
        homeTeamInformation = value;
        setState(() {});
      });
    }
  }

  awayTeamByTeamId() async {
    if (awayTeamInformation == null) {
      matchController
          .getTeamInfo(widget.matchModel.participants![1].id.toString())
          .then((value) {
        awayTeamInformation = value;
        setState(() {});
      });
    }
  }

  getLineUpInformation() {
    if (lineUpMatchModel == null) {
      matchController
          .getFixtureByFixtureId(widget.matchModel.id.toString())
          .then((value) {
        lineUpMatchModel = value;
        if (value == null) {
          setState(() {
            isLoadingLineUp = false;
          });
        } else {
          createTeamLineupFormation(value);
        }
      });
    }
  }

  getStatistics() {
    if (statisticsMatchModel == null) {
      matchController
          .getFixtureByFixtureId(widget.matchModel.id.toString(),
              include: 'statistics')
          .then((value) {
        statisticsMatchModel = value;
        for (var element in (widget.matchModel.statistics ?? [])) {
          totalStatistics.putIfAbsent(
              getStatusName((element.typeId!)), () => []);
          totalStatistics[getStatusName((element.typeId!))]!.add(element);
        }
        setState(() {
          isLoadingState = false;
        });
      });
    }
  }

  //formate line up
  createTeamLineupFormation(MatchModel matchModel) {
    fixtureFormations = matchModel.formations ?? [];
    fixtureLineup = matchModel.lineups ?? [];
    fixtureLineup = fixtureLineup.where((el) => el.typeId == 11).toList();
    formationGroupBy = groupBy(fixtureFormations, (p0) => p0.participantId);
    lineupSorted = groupBy(
      fixtureLineup,
      (Lineup lineups) => (lineups.teamId ?? 0).toInt(),
    );

    if (lineupSorted.isNotEmpty) {
      lineupSorted.entries.first.value.sort(
        (a, b) =>
            (a.formationPosition ?? 0).compareTo(b.formationPosition ?? 0),
      );
      lineupSorted.entries.last.value.sort(
        (a, b) =>
            (a.formationPosition ?? 0).compareTo(b.formationPosition ?? 0),
      );
    }
    num? homeId = getHomeTeam(widget.matchModel.participants ?? [])!.id;
    num? awayId = getAwayTeam(widget.matchModel.participants ?? [])!.id;
    homeLineup.clear();
    awayLineup.clear();
    if (fixtureFormations.isNotEmpty) {
      List<String> formatHomeTeam =
          ("1-${fixtureFormations.firstWhereOrNull((element) => element.participantId == homeId)?.formation ?? "4-3-3"}")
              .split('-');
      List<int> homeTeamFormation = formatHomeTeam.map(int.parse).toList();
      List<String> formatAwayTeam =
          ("1-${fixtureFormations.firstWhereOrNull((element) => element.participantId == awayId)?.formation ?? "4-3-3"}")
              .split('-');
      List<int> awayTeamFormation = formatAwayTeam.map(int.parse).toList();
      for (int chunk in homeTeamFormation) {
        homeLineup.add((lineupSorted[homeId] ?? []).sublist(0, chunk));
        (lineupSorted[homeId] ?? []).removeRange(0, chunk);
      }
      for (int chunk in awayTeamFormation) {
        awayLineup.add((lineupSorted[awayId] ?? []).sublist(0, chunk));
        (lineupSorted[awayId] ?? []).removeRange(0, chunk);
      }
    }
    isLoadingLineUp = false;
    setState(() {});
  }
}
