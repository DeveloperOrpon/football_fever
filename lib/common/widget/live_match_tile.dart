import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

class LiveMatchTile extends StatelessWidget {
  final bool isLive;
  const LiveMatchTile({super.key, this.isLive = false});

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
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: NetImageView(
                          fit: BoxFit.contain,
                          url:
                              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
                        ),
                      ),
                    ),
                    Text(
                      'Manchester',
                      style: Get.theme.textTheme.titleMedium!.copyWith(
                        fontSize: 15.sp,
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
                      child: Text(
                        "3-2",
                        style: Get.theme.textTheme.titleLarge!.copyWith(
                          color: Get.theme.primaryColor,
                          fontSize: Get.width > 600 ? 26.sp : 40.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Get.width > 600 ? 0.verticalSpace : 4.verticalSpace,
                    Row(
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
                          '90+3"',
                          style: Get.theme.textTheme.labelMedium!.copyWith(
                            color: Get.theme.disabledColor,
                            fontSize: Get.width > 600 ? 10.sp : 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: NetImageView(
                          fit: BoxFit.contain,
                          url:
                              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
                        ),
                      ),
                    ),
                    Text(
                      'Dortmund',
                      style: Get.theme.textTheme.titleMedium!.copyWith(
                        fontSize: 15.sp,
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
