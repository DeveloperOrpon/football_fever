import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/image_const.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

import '../../utils/helper/helper_method.dart';
import '../model/match_res.dart';

class LiveMatchTile extends StatelessWidget {
  final bool isLive;
  final MatchModel matchModel;
  const LiveMatchTile(
      {super.key, this.isLive = false, required this.matchModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      height: 140.h,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Get.theme.shadowColor.withOpacity(.6),
            spreadRadius: 3,
            offset: const Offset(4, 2),
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: Get.width * .25,
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
            ),
            child: Text(
              isLive ? "Watch Live" : 'Live Match',
              style: Get.theme.textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: NetImageView(
                          width: Get.width * .3,
                          height: 45.h,
                          fit: BoxFit.contain,
                          url: (getHomeTeam(matchModel.participants ?? [])
                                      ?.imagePath ??
                                  "")
                              .toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          (getHomeTeam(matchModel.participants ?? [])?.name ??
                                  "")
                              .toString(),
                          style: Get.theme.textTheme.titleMedium!.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: (matchModel.scores ?? []).isNotEmpty
                          ? Text(
                              getMatchResult(matchModel.scores ?? []),
                              style: Get.theme.textTheme.titleLarge!.copyWith(
                                color: Get.theme.primaryColor,
                                fontSize: Get.width > 600 ? 26.sp : 40.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Barlow',
                              ),
                            )
                          : Text(
                              '0 : 0',
                              style: Get.theme.textTheme.titleLarge!.copyWith(
                                color: Get.theme.primaryColor,
                                fontSize: Get.width > 600 ? 26.sp : 40.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Barlow',
                              ),
                            ),
                    ),
                    Get.width > 600 ? 0.verticalSpace : 4.verticalSpace,
                    (matchModel.scores ?? []).isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                size: 20.r,
                                color: Get.theme.disabledColor,
                              )
                                  .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true))
                                  .shake(hz: 2, duration: 500.ms, rotation: .4),
                              3.horizontalSpace,
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                '${matchModel.length ?? 0}"',
                                style:
                                    Get.theme.textTheme.labelMedium!.copyWith(
                                  color: Get.theme.disabledColor,
                                  fontSize: Get.width > 600 ? 10.sp : 14.sp,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                footballPlayIcon,
                                height: 15.h,
                                color: Get.theme.primaryColor,
                              ),
                              3.horizontalSpace,
                              Text(
                                timestampToDateFormate(
                                  formate: 'ha',
                                  matchModel.startingAtTimestamp ?? 0,
                                ),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.dividerColor,
                                ),
                              ),
                              5.horizontalSpace,
                            ],
                          ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: NetImageView(
                          width: Get.width * .3,
                          radius: 45.r,
                          height: 45.h,
                          fit: BoxFit.contain,
                          url: (getAwayTeam(matchModel.participants ?? [])
                                      ?.imagePath ??
                                  "")
                              .toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          (getAwayTeam(matchModel.participants ?? [])?.name ??
                                  "")
                              .toString(),
                          style: Get.theme.textTheme.titleMedium!.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
          15.verticalSpace,
        ],
      ),
    );
  }
}
