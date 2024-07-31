import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/dialog/show_add_league_dialog.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/no_data.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appearance/loading/refresh_page.dart';
import '../../../../common/dialog/show_add_team_dialog.dart';
import '../../../../common/widget/favorite_league_card.dart';
import '../../../../common/widget/favorite_team_card.dart';
import '../../../following/controller/following_controller.dart';

class FollowingLeague extends StatefulWidget {
  const FollowingLeague({super.key});

  @override
  State<FollowingLeague> createState() => _FollowingLeagueState();
}

class _FollowingLeagueState extends State<FollowingLeague> {
  final FollowingController followingController = Get.find();
  @override
  void initState() {
    if (followingController.allLeagueList.isEmpty) {
      followingController.getAllLeagues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h).copyWith(
        bottom: 100.h,
      ),
      child: Obx(() {
        return SmartRefresher(
          physics: const BouncingScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          header: refreshLoading(context),
          footer: customFooter,
          controller: followingController.refreshControllerLeague,
          onRefresh: followingController.onRefreshLeague,
          onLoading: followingController.onLoadingLeague,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: const Color(0xFFf9f9f9),
                expandedHeight: 240.h,
                pinned: true,
                toolbarHeight: 220.h,
                flexibleSpace: SizedBox(
                  height: 240.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MY FAVORITE'S",
                        style: Get.theme.textTheme.titleLarge!.copyWith(
                          fontSize: 20.sp,
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(() {
                                return followingController
                                        .isFavoriteLeagueLoading.value
                                    ? LoadingWidget(size: 30.w)
                                    : followingController
                                            .favoriteLeagueList.value.isEmpty
                                        ? InkWell(
                                            onTap: () {
                                              showAddLeagueDialog(context);
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 26.r,
                                                    backgroundColor: Get.theme
                                                        .scaffoldBackgroundColor,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: CircleAvatar(
                                                        radius: 30.r,
                                                        backgroundColor: Get
                                                            .theme.shadowColor,
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 25.r,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                10.verticalSpace,
                                                NoDataCustomWidget(
                                                  bottomSize: 0.h,
                                                  isShowLogo: false,
                                                  titleText:
                                                      'You Have No Favorite League',
                                                  subText:
                                                      'Please Add League for Favorite League List',
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            // height: 150.h,
                                            child: ListView.separated(
                                              padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 20.w)
                                                  .copyWith(left: 0),
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      1.horizontalSpace,
                                              itemBuilder: (context, index) {
                                                return FavoriteLeagueCard(
                                                  isFavorite: true,
                                                  league: followingController
                                                          .favoriteLeagueList[
                                                      index],
                                                );
                                              },
                                              itemCount: followingController
                                                  .favoriteLeagueList.length,
                                            ),
                                          );
                              }),
                            ),
                            2.horizontalSpace,
                            followingController.favoriteLeagueList.value.isEmpty
                                ? const Center()
                                : InkWell(
                                    onTap: () {
                                      showAddLeagueDialog(context);
                                    },
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 26.r,
                                        backgroundColor:
                                            Get.theme.scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircleAvatar(
                                            radius: 30.r,
                                            backgroundColor:
                                                Get.theme.shadowColor,
                                            child: Icon(
                                              Icons.add,
                                              size: 25.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        "OTHER LEAGUE'S",
                        style: Get.theme.textTheme.titleLarge!.copyWith(
                          fontSize: 20.sp,
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              followingController.isLeagueLoading.value
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 200.h,
                        child: Center(
                          child: LoadingWidget(size: 40.w),
                        ),
                      ),
                    ]))
                  : followingController.allLeagueList.isEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                          NoDataCustomWidget(
                            onRefresh: () {
                              followingController.getAllLeagues();
                            },
                          ),
                        ]))
                      : SliverGrid.builder(
                          itemCount: followingController.allLeagueList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width > 600 ? 5 : 4,
                            mainAxisExtent: 180.h,
                            crossAxisSpacing: Get.width > 600 ? 5.w : 0,
                          ),
                          itemBuilder: (context, index) {
                            return FavoriteLeagueCard(
                              isFavorite: false,
                              league: followingController.allLeagueList[index],
                            );
                          },
                        ),
            ],
          ),
        );
      }),
    );
  }
}
