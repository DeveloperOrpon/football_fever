import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:football_fever/utils/helper/helper_method.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../model/match_prediction_res.dart';
import '../model/match_res.dart';

class MatchScoreCustomWidget extends StatefulWidget {
  final MatchModel matchModel;
  final Function() onTap;
  final MatchPredictionRes? matchPredictionRes;

  const MatchScoreCustomWidget(
      {super.key,
      required this.matchModel,
      required this.onTap,
      this.matchPredictionRes});

  @override
  State<MatchScoreCustomWidget> createState() => _MatchScoreCustomWidgetState();
}

class _MatchScoreCustomWidgetState extends State<MatchScoreCustomWidget> {
  @override
  void initState() {
    widget.onTap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      width: Get.width,
      height: 140.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(.05),
            spreadRadius: 1,
            offset: const Offset(1, 1),
            blurRadius: 1,
          )
        ],
      ),
      child: Container(
        width: Get.width,
        padding:
            EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h).copyWith(
          top: 0,
        ),
        height: 165.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.matchPredictionRes == null
                            ? const Center()
                            : Container(
                                margin: EdgeInsets.only(right: 10.w),
                                height: 45.h,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.matchPredictionRes == null
                                      ? ""
                                      : '${probabilityCalculate(widget.matchPredictionRes?.data?.first.probability ?? '0.0')}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                progressColor: probabilityCalculate(widget
                                                .matchPredictionRes
                                                ?.data
                                                ?.first
                                                .probability ??
                                            '0.0') >
                                        probabilityCalculate(widget
                                                .matchPredictionRes
                                                ?.data?[2]
                                                .probability ??
                                            '0.0')
                                    ? Colors.green
                                    : Colors.red,
                                backgroundColor: Colors.transparent,
                                radius: 32.r,
                                lineWidth: 2,
                                percent: widget.matchPredictionRes == null
                                    ? 0.0
                                    : (probabilityCalculate(widget
                                                    .matchPredictionRes
                                                    ?.data
                                                    ?.first
                                                    .probability ??
                                                '0.0')
                                            .toDouble() /
                                        100),
                                restartAnimation: true,
                                center: NetImageView(
                                  type: 'team',
                                  url: getHomeTeam(
                                          widget.matchModel.participants ?? [])!
                                      .imagePath
                                      .toString(),
                                  height: widget.matchPredictionRes == null
                                      ? 65.h
                                      : 45.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              5.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      getHomeTeam(
                                              widget.matchModel.participants ??
                                                  [])!
                                          .name
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                    (widget.matchModel.scores ?? []).isNotEmpty
                                        ? getMatchResult(
                                            widget.matchModel.scores ?? [])
                                        : "0-0",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Barlow',
                                          color: Get.theme.primaryColor,
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 20.r,
                            ),
                            2.horizontalSpace,
                            Text(
                              (widget.matchModel.scores ?? []).isEmpty
                                  ? (getTimeStampParse(
                                      widget.matchModel.startingAtTimestamp ??
                                          0))
                                  : "${widget.matchModel.length}${widget.matchModel.periods?.last.timeAdded != null ? ("+${widget.matchModel.periods!.last.timeAdded}'") : ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                      ).animate(),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                progressColor: probabilityCalculate(widget
                                                .matchPredictionRes
                                                ?.data?[2]
                                                .probability ??
                                            '0.0') >
                                        probabilityCalculate(widget
                                                .matchPredictionRes
                                                ?.data?[1]
                                                .probability ??
                                            '0.0')
                                    ? Colors.green
                                    : Colors.red,
                                backgroundColor: Colors.transparent,
                                radius: 32.r,
                                lineWidth: 2,
                                percent: widget.matchPredictionRes == null
                                    ? 0.0
                                    : (probabilityCalculate(widget
                                                    .matchPredictionRes
                                                    ?.data?[2]
                                                    .probability ??
                                                '0.0')
                                            .toDouble() /
                                        100),
                                center: NetImageView(
                                  type: 'team',
                                  url: getAwayTeam(
                                          widget.matchModel.participants ?? [])!
                                      .imagePath
                                      .toString(),
                                  height: widget.matchPredictionRes == null
                                      ? 65.h
                                      : 45.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              5.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      getAwayTeam(
                                              widget.matchModel.participants ??
                                                  [])!
                                          .name
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        widget.matchPredictionRes == null
                            ? const Center()
                            : Container(
                                margin: EdgeInsets.only(left: 10.w),
                                height: 45.h,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.matchPredictionRes == null
                                      ? ""
                                      : '${probabilityCalculate(widget.matchPredictionRes?.data?[2].probability ?? '0.0')}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
