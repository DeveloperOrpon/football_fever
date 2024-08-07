import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/match_res.dart';
import 'package:football_fever/view/match/page/date_ways_all_matches.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../clipper/tri_angle_clipper.dart';

class TimeTile extends StatelessWidget {
  final bool onlyTitle;
  final String date;
  final Map<String, List<MatchModel>>? map;
  final String? matchCount;
  const TimeTile(
      {super.key,
      required this.date,
      this.matchCount,
      this.map,
      this.onlyTitle = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      // height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 80,
                height: onlyTitle ? 5 : 25,
                color: Get.theme.primaryColor,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1000.ms),
          10.horizontalSpace,
          onlyTitle
              ? Text(
                  date,
                  style: Get.theme.textTheme.titleLarge!.copyWith(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateTime.tryParse(date) == null
                          ? date
                          : DateFormat('MMMM d, yyyy')
                              .format(DateTime.parse(date)),
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    map != null
                        ? InkWell(
                            onTap: () {
                              Get.to(
                                  DateWaysAllMatches(
                                    map: map!,
                                    date: date,
                                  ),
                                  transition: Transition.fadeIn,
                                  duration: 500.ms);
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                    ),
                                    border: Border.all(
                                      color: Get.theme.primaryColor,
                                      width: .3,
                                    ),
                                  ),
                                  child: Text(
                                    "$matchCount Matches",
                                    style: Get.theme.textTheme.titleLarge!
                                        .copyWith(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "More",
                                        style: Get.theme.textTheme.titleLarge!
                                            .copyWith(
                                          color:
                                              Get.theme.scaffoldBackgroundColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp,
                                        ),
                                      )
                                          .animate(
                                              onPlay: (controller) =>
                                                  controller.repeat(
                                                      reverse: false,
                                                      period: 1000.ms))
                                          .shimmer(
                                            duration: 2000.ms,
                                            color: Colors.black,
                                          ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                        size: 10.r,
                                      )
                                          .animate(
                                              onPlay: (controller) =>
                                                  controller.repeat(
                                                      reverse: false,
                                                      period: 1000.ms))
                                          .shimmer(
                                            delay: 500.ms,
                                            duration: 500.ms,
                                            color: Colors.black,
                                          )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                              ),
                              border: Border.all(
                                color: Get.theme.primaryColor,
                                width: .3,
                              ),
                            ),
                            child: Text(
                              "ALL MATCHES",
                              style: Get.theme.textTheme.titleLarge!.copyWith(
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                  ],
                ),
          10.horizontalSpace,
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: 80,
              height: onlyTitle ? 5 : 25,
              color: Get.theme.primaryColor,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1000.ms, angle: 90),
        ],
      ),
    );
  }
}
