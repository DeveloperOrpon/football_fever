import 'package:animated_rail/animated_rail/animated_rail.dart';
import 'package:animated_rail/animated_rail/rail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/image_const.dart';
import 'package:football_fever/view/home/component/bottom_bar.dart';
import 'package:football_fever/view/home/component/bottom_tab/following_tab.dart';
import 'package:football_fever/view/home/component/bottom_tab/score_tab.dart';
import 'package:football_fever/view/match/controller/match_controller.dart';
import 'package:football_fever/view/news/page/news_page.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    MatchController matchController = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedRail(
            menuIcon: Image.asset(
              menuIcon,
              color: Colors.white,
            ),
            isStatic: true,
            background: const Color(0XFFfec142),
            maxWidth: Get.width * .6,
            width: 20.w,
            direction: TextDirection.rtl,
            railTileConfig: RailTileConfig(
              iconSize: 25.r,
              iconColor: const Color(0XFFfec142),
              expandedTextStyle: TextStyle(fontSize: 15.sp),
              collapsedTextStyle:
                  TextStyle(fontSize: 12.sp, color: Colors.white),
              activeColor: Colors.indigo,
              // iconPadding: EdgeInsets.symmetric(vertical: 5.h),
              hideCollapsedText: true,
            ),
            cursorSize: Size(60.w, 80.h),
            cursorActionType: CursorActionTrigger.clickAndDrag,
            item: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                color: const Color(0xFFf9f9f9),
                margin: EdgeInsets.only(
                  right: 10.w,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.w,
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
                    Expanded(
                      child: PageView(
                        controller: homeController.pageController,
                        reverse: true,
                        onPageChanged: (index) {
                          homeController.homeBottomIndex.value = index;
                        },
                        children: const [
                          ScoreTab(),
                          FollowingTab(),
                          NewsPage(),
                          Icon(Icons.home)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 0,
            left: 0,
            child: const CustomBottomBar(),
          ),
        ],
      ),
    );
  }
}
