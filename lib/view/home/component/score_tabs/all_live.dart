import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/league_title.dart';
import 'package:football_fever/common/widget/live_match_tile.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/no_data.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:football_fever/view/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appearance/loading/refresh_page.dart';

class AllLiveTab extends StatefulWidget {
  const AllLiveTab({super.key});

  @override
  State<AllLiveTab> createState() => _AllLiveTabState();
}

class _AllLiveTabState extends State<AllLiveTab> {
  final HomeController homeController = Get.find();
  @override
  void initState() {
    homeController.getScoreLiveMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.isLiveScoreMatch.value
          ? Center(
              child: LoadingWidget(size: 40.w),
            )
          : Padding(
              padding: EdgeInsets.only(bottom: 110.h, right: 15.w, left: 10.w),
              child: SmartRefresher(
                physics: const BouncingScrollPhysics(),
                enablePullDown: true,
                enablePullUp: true,
                header: refreshLoading(context),
                footer: customFooter,
                controller: homeController.refreshControllerLiveMatches,
                onRefresh: homeController.onRefreshLiveMatches,
                onLoading: homeController.onLoadingLiveMatches,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  children: [
                    const TimeTile(
                      date: 'Panel Live',
                      onlyTitle: true,
                    ),
                    NoDataCustomWidget(
                      bottomSize: 20.h,
                      onRefresh: () {},
                      buttonText: 'Refresh',
                      titleText: 'No Live Match Available',
                    ),
                    const TimeTile(
                      date: 'Other Lives',
                      onlyTitle: true,
                    ),
                    ...homeController.liveMatchList.map((matchModel) {
                      return LiveMatchTile(matchModel: matchModel);
                    }),
                    if (homeController.liveMatchList.isEmpty)
                      NoDataCustomWidget(
                        bottomSize: 20.h,
                        onRefresh: () {},
                        buttonText: 'Refresh',
                        titleText: 'No Live Match Available',
                      ),
                    120.verticalSpace,
                  ],
                ),
              ),
            );
    });
  }
}
