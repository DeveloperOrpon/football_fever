import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/season_match_res.dart';
import 'net_image.dart';

class ScorePlayerTile extends StatelessWidget {
  final TopScorer topScorer;
  const ScorePlayerTile({super.key, required this.topScorer});

  @override
  Widget build(BuildContext context) {
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
                '${topScorer.position}',
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
            child: Stack(
              children: [
                Container(
                  height: Get.width > 600 ? 60.h : 40.h,
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: .05,
                    child: NetImageView(
                      url: '${topScorer.player?.country?.imagePath}',
                    ),
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: SizedBox(
                        height: Get.width > 600 ? 60.h : 40.h,
                        width: Get.width > 600 ? 60.h : 40.h,
                        child: NetImageView(
                            url: topScorer.player?.imagePath ?? ""),
                      ),
                    ),
                    5.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            '${topScorer.player?.name} ',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp,
                                    ),
                          ),
                          Text(
                            maxLines: 1,
                            '${topScorer.player?.country?.name} ',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 10.sp,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      topScorer.position.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    5.horizontalSpace,
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    ).animate().blurXY(begin: 5, end: 0, duration: 600.ms);
  }
}
