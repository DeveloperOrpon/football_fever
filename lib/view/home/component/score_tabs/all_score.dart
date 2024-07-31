import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/league_title.dart';
import 'package:football_fever/common/widget/live_match_tile.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/no_data.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:football_fever/utils/helper/helper_method.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../appearance/loading/refresh_page.dart';
import '../../../../common/widget/upcoming_match_tile.dart';
import '../../controller/home_controller.dart';

class AllScoreTab extends StatelessWidget {
  const AllScoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 110.h),
        child: SmartRefresher(
          physics: const BouncingScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          header: refreshLoading(context),
          footer: customFooter,
          controller: homeController.refreshControllerAllScore,
          onRefresh: homeController.onRefreshAllScore,
          onLoading: homeController.onLoadingAllScore,
          child: !homeController.scorePageLoading.value
              ? homeController.homeAllDateWaysMatchesList.isEmpty
                  ? const Center(child: NoDataCustomWidget())
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...homeController
                                  .homeAllDateWaysMatchesList.entries
                                  .map((dateMatch) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TimeTile(
                                      map: dateMatch.value,
                                      date: fixtureDateFormateQuery(
                                                  DateTime.now()) ==
                                              dateMatch.key
                                          ? 'TODAY'
                                          : DateFormat('MMMM d, yyyy').format(
                                              DateTime.parse(dateMatch.key)),
                                      matchCount:
                                          dateWayMatchCount(dateMatch.value),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: dateMatch.value.entries
                                            .map((e) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    LeagueTitle(
                                                      name: e.key,
                                                      icon:
                                                          '${dateMatch.value[e.key]![0].league!.imagePath}',
                                                    ),
                                                    ...List.generate(
                                                      e.value.length,
                                                      (index) {
                                                        return (e.value[index]
                                                                        .scores ??
                                                                    [])
                                                                .isEmpty
                                                            ? UpcomingMatchTile(
                                                                matchModel:
                                                                    e.value[
                                                                        index],
                                                              )
                                                            : LiveMatchTile(
                                                                matchModel:
                                                                    e.value[
                                                                        index],
                                                              );
                                                      },
                                                    )
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                        ])),
                      ],
                    )
              : Center(
                  child: LoadingWidget(size: 40.h),
                ),
        ),
      );
    });
  }
}
