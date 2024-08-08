import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:football_fever/utils/helper/helper_method.dart';
import 'package:get/get.dart';

import '../../../appearance/image_const.dart';
import '../../../common/model/match_res.dart';
import '../../../common/widget/lineup_player_position.dart';

class LineupTab extends StatefulWidget {
  final MatchModel? lineUpMatchModel;
  final MatchModel matchModel;
  final Function() onInit;
  final List<List<Lineup>> awayLineup;
  final List<List<Lineup>> homeLineup;
  const LineupTab(
      {super.key,
      required this.onInit,
      required this.awayLineup,
      required this.homeLineup,
      required this.lineUpMatchModel,
      required this.matchModel});

  @override
  State<LineupTab> createState() => _LineupTabState();
}

class _LineupTabState extends State<LineupTab> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  int segmentedControlValue = 0;

  @override
  Widget build(BuildContext context) {
    return widget.lineUpMatchModel == null
        ? Center(
            child: LoadingWidget(
              size: 40.h,
            ),
          )
        : Column(
            children: [
              //team lineup info
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 23.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: NetImageView(
                                    url:
                                        '${getHomeTeam(widget.matchModel.participants ?? [])!.imagePath}',
                                    height: 60.w,
                                    type: 'team'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${getHomeTeam(widget.matchModel.participants ?? [])!.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                ),
                                if (widget
                                    .lineUpMatchModel!.formations!.isNotEmpty)
                                  Text(
                                    '${widget.lineUpMatchModel!.formations!.firstWhere((element) => element.location == Location.HOME).formation}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '-',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 22.sp,
                          ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  textAlign: TextAlign.right,
                                  getAwayTeam(widget.matchModel.participants!)!
                                      .name
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                ),
                                if (widget
                                    .lineUpMatchModel!.formations!.isNotEmpty)
                                  Text(
                                    '${widget.lineUpMatchModel!.formations!.firstWhere((element) => element.location == Location.AWAY).formation}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 23.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: NetImageView(
                                    url:
                                        '${getAwayTeam(widget.matchModel.participants ?? [])!.imagePath}',
                                    height: 60.w,
                                    type: 'team'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //tab
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: CupertinoSlidingSegmentedControl(
                        backgroundColor: Get.theme.secondaryHeaderColor,
                        thumbColor: Get.theme.primaryColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 8.w),
                        groupValue: segmentedControlValue,
                        children: {
                          0: Text(
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                            '${getHomeTeam(widget.matchModel.participants ?? [])!.name}'
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: segmentedControlValue == 0
                                    ? Colors.white
                                    : null),
                          ),
                          1: Text(
                            maxLines: 1,
                            '${getAwayTeam(widget.matchModel.participants ?? [])!.name}'
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: segmentedControlValue == 1
                                    ? Colors.white
                                    : null),
                          ),
                        },
                        onValueChanged: (value) {
                          setState(() {
                            segmentedControlValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if ((widget.lineUpMatchModel?.formations ?? []).isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w,
                        ),
                        height: 250.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Card(
                          elevation: 2,
                          shadowColor: Get.theme.shadowColor.withOpacity(.5),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                footballGroundBg,
                                width: Get.width,
                                fit: BoxFit.fill,
                                color: Get.theme.disabledColor.withOpacity(.2),
                              ),
                              Column(
                                children: [
                                  ...(segmentedControlValue == 0
                                          ? widget.homeLineup
                                          : widget.awayLineup)
                                      .map(
                                    (element) => Expanded(
                                      child: Row(
                                        children: [
                                          ...element.map(
                                            (player) => Expanded(
                                              child: Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    LineUpPlayerPosition(
                                                      lineup: player,
                                                      title: player.jerseyNumber
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ).animate().flipV(),

                    ///all player information
                    if ((widget.lineUpMatchModel?.lineups ?? []).isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TimeTile(
                              date: 'Lineups',
                              onlyTitle: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0.h, horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: ((widget.lineUpMatchModel?.lineups ??
                                            [])
                                        .where((element) =>
                                            element.teamId ==
                                                (segmentedControlValue == 0
                                                        ? getHomeTeam(widget
                                                                .matchModel
                                                                .participants ??
                                                            [])
                                                        : getAwayTeam(widget
                                                                .matchModel
                                                                .participants ??
                                                            []))!
                                                    .id &&
                                            element.typeId == 11))
                                    .map((e) => _homeTeamPlayer(e, context))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // divider

                    if ((widget.lineUpMatchModel?.lineups ?? []).isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TimeTile(
                              date: 'Beach Players',
                              onlyTitle: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0.h, horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: ((widget.lineUpMatchModel?.lineups ??
                                            [])
                                        .where((element) =>
                                            element.teamId ==
                                                (segmentedControlValue == 0
                                                        ? getHomeTeam(widget
                                                                .matchModel
                                                                .participants ??
                                                            [])
                                                        : getAwayTeam(widget
                                                                .matchModel
                                                                .participants ??
                                                            []))!
                                                    .id &&
                                            element.typeId == 12))
                                    .map(
                                      (e) => _homeTeamPlayer(e, context),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    //Coach
                    if ((widget.lineUpMatchModel?.coaches ?? []).isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TimeTile(
                              date: 'Coach',
                              onlyTitle: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0.h, horizontal: 12.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ),
                                // margin: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Get.theme.primaryColor,
                                      ),
                                      width: Get.width > 600 ? 50.h : 40.h,
                                      height: Get.width > 600 ? 60.h : 40.h,
                                      child: Center(
                                        child: Text(
                                          'C',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: Get.theme.primaryColor
                                            .withOpacity(.1),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            child: SizedBox(
                                              height:
                                                  Get.width > 600 ? 60.h : 40.h,
                                              width:
                                                  Get.width > 600 ? 60.h : 40.h,
                                              child: NetImageView(
                                                url:
                                                    '${widget.lineUpMatchModel?.coaches?[segmentedControlValue].imagePath}',
                                              ),
                                            ),
                                          ),
                                          5.horizontalSpace,
                                          Expanded(
                                            child: Text(
                                              maxLines: 1,
                                              '${'${widget.lineUpMatchModel?.coaches?[segmentedControlValue].name}'} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 14.sp,
                                                  ),
                                            ),
                                          ),
                                          5.horizontalSpace,
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _homeTeamPlayer(Lineup e, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.theme.primaryColor,
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(.8),
            ),
            width: Get.width > 600 ? 50.h : 40.h,
            height: Get.width > 600 ? 60.h : 40.h,
            child: Center(
              child: Text(
                '${e.jerseyNumber}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(.05),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: SizedBox(
                    height: Get.width > 600 ? 60.h : 40.h,
                    width: Get.width > 600 ? 60.h : 40.h,
                    child: NetImageView(url: e.player?.imagePath ?? ""),
                  ),
                ),
                5.horizontalSpace,
                Expanded(
                  child: Text(
                    maxLines: 1,
                    '${e.playerName} ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                        ),
                  ),
                ),
                Text(
                  getPositionName((e.positionId ?? 0).toInt()),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10.sp,
                      ),
                ),
                5.horizontalSpace,
              ],
            ),
          ))
        ],
      ),
    ).animate().blurXY(begin: 5, end: 0, duration: 600.ms);
  }
}
