import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../following_tabs/following_league.dart';
import '../following_tabs/following_matches.dart';
import '../following_tabs/following_team.dart';

class FollowingTab extends StatelessWidget {
  const FollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  tabs: const [
                    Tab(
                      text: 'MATCHES',
                    ),
                    Tab(
                      text: 'TEAMS',
                    ),
                    Tab(
                      text: 'LEAGUES',
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
              FollowingMatches(),
              FollowingTeam(),
              FollowingLeague(),
            ]),
          ),
        ],
      ),
    );
  }
}
