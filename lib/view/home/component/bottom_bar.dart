import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  SnakeShape snakeShape =
      Get.width > 600 ? SnakeShape.rectangle : SnakeShape.circle;
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SnakeNavigationBar.color(
        elevation: 1,
        shadowColor: Get.theme.shadowColor.withOpacity(.2),
        backgroundColor: Colors.white,
        height: 80.h,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: snakeShape,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.elliptical(60, 140),
            topRight: const Radius.elliptical(60, 140),
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        snakeViewColor: const Color(0xFFfec142),
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? const Color(0xFFfec142) : null,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: homeController.homeBottomIndex.value,
        onTap: (index) {
          homeController.pageController.animateToPage(
            index,
            duration: 400.ms,
            curve: Curves.fastLinearToSlowEaseIn,
          );
          homeController.homeBottomIndex.value = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Text(
              'Scores',
              style: Get.theme.textTheme.titleSmall!.copyWith(
                color: homeController.homeBottomIndex.value == 0
                    ? Colors.white
                    : null,
              ),
            ),
            label: 'Scores',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'Following',
              style: Get.theme.textTheme.titleSmall!.copyWith(
                color: homeController.homeBottomIndex.value == 1
                    ? Colors.white
                    : null,
              ),
            ),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'News',
              style: Get.theme.textTheme.titleSmall!.copyWith(
                color: homeController.homeBottomIndex.value == 2
                    ? Colors.white
                    : null,
              ),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'League',
              style: Get.theme.textTheme.titleSmall!.copyWith(
                color: homeController.homeBottomIndex.value == 3
                    ? Colors.white
                    : null,
              ),
            ),
            label: 'League',
          ),
        ],
      );
    });
  }
}

class CustomIcons {
  CustomIcons._();

  static const _kFontFamily = 'IconFont';

  static const IconData calendar = IconData(0xe800, fontFamily: _kFontFamily);
  static const IconData podcasts = IconData(0xe801, fontFamily: _kFontFamily);
  static const IconData home = IconData(0xe802, fontFamily: _kFontFamily);
  static const IconData search = IconData(0xe803, fontFamily: _kFontFamily);
  static const IconData tickets = IconData(0xe804, fontFamily: _kFontFamily);
}
