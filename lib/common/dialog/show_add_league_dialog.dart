import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/loading/refresh_page.dart';
import 'package:football_fever/common/widget/favorite_league_card.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../view/following/controller/following_controller.dart';
import '../widget/loading_widget.dart';
import '../widget/net_image.dart';
import '../widget/no_data.dart';

showAddLeagueDialog(BuildContext context) {
  showCupertinoModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const ModalWillScope(),
  );
}

class ModalWillScope extends StatelessWidget {
  const ModalWillScope({super.key});

  @override
  Widget build(BuildContext context) {
    final FollowingController followingController = Get.find();
    return SizedBox(
      height: Get.height * .8,
      child: Material(
          child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFFf9f9f9),
        navigationBar: CupertinoNavigationBar(
            trailing: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6.h,
                horizontal: 5.w,
              ),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  width: 1,
                  color: Get.theme.dividerColor.withOpacity(.7),
                ),
              ),
              child: Text(
                'Add Favorite',
                style: Get.theme.textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            border: Border.all(color: Colors.transparent),
            backgroundColor: Colors.white,
            // leading: const Center(),
            middle: Text(
              'Available League',
              style: Get.theme.textTheme.titleLarge,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h)
              .copyWith(bottom: 20.h),
          child: Column(
            children: [
              Card(
                elevation: 3,
                shadowColor: Get.theme.shadowColor.withOpacity(.5),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  width: Get.width,
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Get.theme.scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return followingController.favoriteLeagueList.isEmpty
                            ? const Center()
                            : Text(
                                '- Selected League -',
                                style: Get.theme.textTheme.labelMedium,
                              );
                      }),
                      Expanded(
                        child: SizedBox(
                          height: 150.h,
                          width: Get.width,
                          child: Obx(() {
                            return followingController
                                    .favoriteLeagueList.isEmpty
                                ? const Center(
                                    child: NoDataCustomWidget(
                                      isShowLogo: false,
                                      titleText: 'No League Selected',
                                      subText: 'Tap to select favorite leagues',
                                      bottomSize: 0,
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                            vertical: 5.h, horizontal: 20.w)
                                        .copyWith(left: 0),
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        1.horizontalSpace,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 60.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: NetImageView(
                                          fit: BoxFit.contain,
                                          url: followingController
                                                  .favoriteLeagueList[index]
                                                  .imagePath ??
                                              '',
                                        ),
                                      );
                                    },
                                    itemCount: followingController
                                        .favoriteLeagueList.length,
                                  );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return SmartRefresher(
                    physics: const BouncingScrollPhysics(),
                    enablePullDown: true,
                    enablePullUp: true,
                    header: refreshLoading(context),
                    footer: customFooter,
                    controller:
                        followingController.refreshControllerLeaguePopUp,
                    onRefresh: followingController.onRefreshLeaguePopUp,
                    onLoading: followingController.onLoadingLeaguePopUp,
                    child: followingController.isLeagueLoading.value
                        ? SizedBox(
                            height: 200.h,
                            child: Center(
                              child: LoadingWidget(size: 40.w),
                            ),
                          )
                        : followingController.allLeagueList.isEmpty
                            ? NoDataCustomWidget(
                                onRefresh: () {},
                              )
                            : GridView.builder(
                                itemCount:
                                    followingController.allLeagueList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width > 600 ? 5 : 4,
                                  mainAxisExtent: 180.h,
                                  crossAxisSpacing: Get.width > 600 ? 5.w : 0,
                                ),
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    return FavoriteLeagueCard(
                                      isFavorite: followingController
                                          .favoriteLeagueList
                                          .contains(followingController
                                              .allLeagueList[index]),
                                      league: followingController
                                          .allLeagueList[index],
                                    );
                                  });
                                },
                              ),
                  );
                }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
