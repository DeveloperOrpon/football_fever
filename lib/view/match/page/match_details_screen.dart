import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/team_model_res.dart';
import 'package:football_fever/common/widget/match_score_widget.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:football_fever/view/match/tabs/rounds_tab.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/model/match_prediction_res.dart';
import '../../../common/model/match_res.dart';
import '../../../common/widget/net_image.dart';
import '../../../utils/helper/helper_method.dart';
import '../controller/match_controller.dart';
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
  List<MatchModel> leagueMatches = [];
  final MatchController matchController = Get.find();
  bool isLoading = false;
  bool isLoadingRound = true;
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
        title: Row(
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
                    homeTeamInfo: homeTeamInformation,
                    onInit: getTeamByTeamId,
                  )
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
    if (leagueMatches.isEmpty) {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoadingRound = true;
        });
      });
      matchController
          .getFixtureByFixtureData(widget.matchModel.seasonId.toString())
          .then((value) {
        for (MatchModel match in (value?.data?.fixtures ?? [])) {
          String time = DateFormat("dd MMM yyyy")
              .format(timeStampDate(match.startingAtTimestamp!));
          String todayDate = DateFormat("dd MMM yyyy").format(DateTime.now());

          if (time == todayDate) {
            leagueMatches.add(match);
          }
        }
        isLoadingRound = false;
        setState(() {});
      });
    }
  }

  getTeamByTeamId() {
    if (homeTeamInformation == null) {
      matchController
          .getTeamInfo(widget.matchModel.participants![0].id.toString())
          .then((value) {
        homeTeamInformation = value;
        setState(() {});
      });
    }
  }
}
