import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/match_res.dart';
import 'package:football_fever/common/model/team_model_res.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:football_fever/common/widget/score_player_tile.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:get/get.dart';

import '../../../common/model/season_match_res.dart';
import '../../../common/widget/league_title.dart';
import '../../../common/widget/live_match_tile.dart';
import '../../../common/widget/upcoming_match_tile.dart';

class PreviousTab extends StatefulWidget {
  final MatchModel matchModel;
  final TeamModelRes? homeTeamInfo;
  final TeamModelRes? awayTeamInfo;
  final List<TopScorer> topScore;
  final List<TopScorer> topAssists;

  final Function() onInit;

  const PreviousTab(
      {super.key,
      this.homeTeamInfo,
      required this.onInit,
      this.awayTeamInfo,
      required this.topScore,
      required this.topAssists,
      required this.matchModel});

  @override
  State<PreviousTab> createState() => _PreviousTabState();
}

class _PreviousTabState extends State<PreviousTab> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            border: Border.all(
              color: Get.theme.primaryColor.withOpacity(.5),
            ),
            gradient: LinearGradient(
              colors: [
                Get.theme.primaryColor,
                Colors.transparent,
              ],
            ),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: .1,
                  child: NetImageView(
                    url: '${widget.matchModel.league?.imagePath}',
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 5.w,
                    ),
                    width: 100.w,
                    alignment: Alignment.center,
                    child: NetImageView(
                      fit: BoxFit.contain,
                      width: 100.w,
                      url: '${widget.matchModel.league?.imagePath}',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.matchModel.league?.name ?? '',
                          style: Get.theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              fontFamily: 'Barlow'),
                        ),
                        Text(
                          'Top Scorers',
                          style: Get.theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  6.horizontalSpace,
                ],
              )
            ],
          ),
        ),
        Container(
          padding: REdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 5.w,
          ),
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.topScore.map((topScorer) {
                return ScorePlayerTile(topScorer: topScorer);
              }).take(2)
            ],
          ),
        ),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            border: Border.all(
              color: Get.theme.primaryColor.withOpacity(.5),
            ),
            gradient: LinearGradient(
              colors: [
                Get.theme.primaryColor,
                Colors.transparent,
              ],
            ),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: .1,
                  child: NetImageView(
                    url: '${widget.matchModel.league?.imagePath}',
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 5.w,
                    ),
                    width: 100.w,
                    alignment: Alignment.center,
                    child: NetImageView(
                      fit: BoxFit.contain,
                      width: 100.w,
                      url: '${widget.matchModel.league?.imagePath}',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.matchModel.league?.name ?? '',
                          style: Get.theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              fontFamily: 'Barlow'),
                        ),
                        Text(
                          'Top Assists',
                          style: Get.theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  6.horizontalSpace,
                ],
              )
            ],
          ),
        ),
        Container(
          padding: REdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 5.w,
          ),
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.topAssists.map((topScorer) {
                return ScorePlayerTile(topScorer: topScorer);
              }).take(2)
            ],
          ),
        ),
        const TimeTile(
          date: 'Latest Matches',
          onlyTitle: true,
        ),
        LeagueTitle(
          name: widget.homeTeamInfo?.data?.name ?? '',
          icon: widget.homeTeamInfo?.data?.imagePath ?? '',
        ),
        ...List.generate((widget.homeTeamInfo?.data?.data ?? []).length,
            (index) {
          return ((widget.homeTeamInfo?.data?.data ?? [])[index].scores ?? [])
                  .isEmpty
              ? UpcomingMatchTile(
                  matchModel: (widget.homeTeamInfo?.data?.data ?? [])[index])
              : LiveMatchTile(
                  matchModel: (widget.homeTeamInfo?.data?.data ?? [])[index]);
        }).take(2),
        LeagueTitle(
          name: widget.awayTeamInfo?.data?.name ?? '',
          icon: widget.awayTeamInfo?.data?.imagePath ?? '',
        ),
        ...List.generate((widget.awayTeamInfo?.data?.data ?? []).length,
            (index) {
          return ((widget.awayTeamInfo?.data?.data ?? [])[index].scores ?? [])
                  .isEmpty
              ? UpcomingMatchTile(
                  matchModel: (widget.awayTeamInfo?.data?.data ?? [])[index])
              : LiveMatchTile(
                  matchModel: (widget.awayTeamInfo?.data?.data ?? [])[index]);
        }).take(2),
      ],
    );
  }
}
