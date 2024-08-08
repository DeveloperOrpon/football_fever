import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

import '../model/match_res.dart';

class LineUpPlayerPosition extends StatelessWidget {
  final bool isRightTeam;
  final Lineup lineup;
  final String title;
  const LineUpPlayerPosition(
      {super.key,
      this.isRightTeam = false,
      required this.title,
      required this.lineup});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Get.theme.primaryColor.withOpacity(.1),
          child: CircleAvatar(
            radius: Get.width * .04,
            backgroundColor: Colors.black,
            // backgroundColor: isRightTeam ? Colors.red : const Color(0xFF153D8A),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: NetImageView(
                url: lineup.player?.imagePath ?? '',
              ),
            ),
          ).animate().fadeIn().scaleXY(begin: 1.5, end: 1, duration: 400.ms),
        ),
        Container(
          width: 40.w,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor.withOpacity(.1),
            border: Border(
              bottom: BorderSide(
                color: Get.theme.primaryColor,
              ),
            ),
          ),
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ).animate().slideY(delay: 300.ms, duration: 600.ms)
      ],
    );
  }
}
