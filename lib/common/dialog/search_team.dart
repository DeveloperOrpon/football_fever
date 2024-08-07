import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/view/following/controller/following_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../widget/favorite_team_card.dart';

Widget getSearchTeamDialog(BuildContext context) {
  final debouncer = Debouncer(delay: 500.ms);
  FollowingController followingController = Get.find();
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return FloatingSearchBar(
    backgroundColor: const Color(0xFFf9f9f9),
    elevation: 0,
    height: Get.width > 600 ? 60.h : 48.h,
    hint: 'Search Team',
    hintStyle: TextStyle(
      fontSize: 16.sp,
    ),
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    margins: EdgeInsets.zero,
    padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(
      left: 30.h,
    ),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 1.0 : -1.0,
    openAxisAlignment: 0.0,
    width: Get.width * .46,
    openWidth: Get.width,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10.r),
    ),
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      debouncer.call(() {
        FocusScope.of(context).unfocus();
        if (query.isNotEmpty) {
          followingController.teamSearch(query);
        }
      });
    },
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction.icon(
        icon: Icon(
          CupertinoIcons.search,
          size: 25.r,
        ),
        onTap: () {},
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return Container(
        height: Get.height * .6,
        decoration: BoxDecoration(
          color: const Color(0xFFf9f9f9),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 5.h,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0).copyWith(
          bottom: 100.h,
          right: 20.w,
        ),
        child: Obx(() {
          return followingController.isSearchLoading.value
              ? LoadingWidget(size: 40.w)
              : GridView.builder(
                  itemCount: followingController.availableSearchTeam.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.width > 600 ? 5 : 4,
                    mainAxisExtent: 170.h,
                    crossAxisSpacing: Get.width > 600 ? 5.w : 8.w,
                    mainAxisSpacing: 5.h,
                  ),
                  itemBuilder: (context, index) {
                    return FavoriteTeamCard(
                      isFavorite: followingController.favoriteTeamList
                                  .firstWhereOrNull((e) =>
                                      e.id ==
                                      followingController
                                          .allTeamList[index].id) ==
                              null
                          ? false
                          : true,
                      team: followingController.availableSearchTeam[index],
                    );
                  },
                );
        }),
      );
    },
  );
}
