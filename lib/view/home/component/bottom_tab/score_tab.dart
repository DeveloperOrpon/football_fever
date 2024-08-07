import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/view/home/component/score_tabs/all_score.dart';
import 'package:get/get.dart';

import '../score_tabs/all_live.dart';

class ScoreTab extends StatelessWidget {
  const ScoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: Get.width,
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Get.theme.primaryColor,
                  indicatorWeight: 1,
                  labelStyle: Get.theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width > 600 ? 14.sp : null,
                  ),
                  unselectedLabelStyle:
                      Get.theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Get.theme.disabledColor,
                    fontSize: Get.width > 600 ? 14.sp : null,
                  ),
                  tabs: [
                    const Tab(
                      text: 'ALL SCORES',
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('ALL LIVES'),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h, left: 3.w),
                            child: Icon(
                              Icons.live_tv_rounded,
                              size: 20.r,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 800.ms).slideX(
                      begin: 1,
                      duration: 400.ms,
                      curve: Curves.fastLinearToSlowEaseIn,
                    ),
                10.verticalSpace,
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(children: [
              AllScoreTab(),
              AllLiveTab(),
            ]),
          ),
        ],
      ),
    );
  }
}
