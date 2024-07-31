import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/match_res.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:football_fever/view/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appearance/image_const.dart';
import '../../../appearance/loading/refresh_page.dart';
import '../../../common/widget/league_title.dart';
import '../../../common/widget/live_match_tile.dart';
import '../../../common/widget/upcoming_match_tile.dart';

class DateWaysAllMatches extends StatefulWidget {
  final String date;
  final Map<String, List<MatchModel>> map;
  const DateWaysAllMatches({super.key, required this.map, required this.date});

  @override
  State<DateWaysAllMatches> createState() => _DateWaysAllMatchesState();
}

class _DateWaysAllMatchesState extends State<DateWaysAllMatches> {
  HomeController homeController = Get.find();

  addInitData() async {
    homeController.dayAllDateWaysMatches.value = {};
    homeController.dayAllDateWaysMatches.value = widget.map;
    homeController.allDayMatchLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    addInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Container(
          padding: EdgeInsets.only(
            left: 20.w,
            bottom: 10.h,
          ),
          color: Get.theme.scaffoldBackgroundColor,
          height: 100.h,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              appNameLogo,
              width: Get.width * .5,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TimeTile(
              date: DateTime.tryParse(widget.date) == null
                  ? widget.date
                  : DateFormat('MMMM d, yyyy')
                      .format(DateTime.parse(widget.date))),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Obx(() {
                return SmartRefresher(
                    physics: const BouncingScrollPhysics(),
                    enablePullDown: true,
                    enablePullUp: true,
                    header: refreshLoading(context, color: Colors.red),
                    footer: customFooter,
                    controller: homeController.refreshController,
                    onRefresh: () {
                      homeController.onRefreshDayAllMatches(widget.date);
                    },
                    onLoading: () {
                      homeController.onLoadingDayAllMatches(widget.date);
                    },
                    child: homeController.allDayMatchLoading.value
                        ? LoadingWidget(size: 40.w)
                        : ListView(
                            // mainAxisSize: MainAxisSize.min,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              ...homeController.dayAllDateWaysMatches.entries
                                  .map((e) {
                                return e.value.isEmpty
                                    ? Text('${e.key}')
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          LeagueTitle(
                                            name: e.key,
                                            icon:
                                                '${e.value[0].league!.imagePath}',
                                          ),
                                          ...List.generate(
                                            e.value.length,
                                            (index) {
                                              return (e.value[index].scores ??
                                                          [])
                                                      .isEmpty
                                                  ? UpcomingMatchTile(
                                                      matchModel:
                                                          e.value[index],
                                                    )
                                                  : LiveMatchTile(
                                                      matchModel:
                                                          e.value[index],
                                                    );
                                            },
                                          )
                                        ],
                                      );
                              })
                            ],
                          ));
              }),
            ),
          ),
        ],
      ),
    );
  }
}
