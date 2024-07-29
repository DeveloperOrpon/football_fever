import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/themes/colors.dart';
import 'package:get/get.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../splash/controller/splash_controller.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Obx(() {
                return InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    // Get.offAll(HomePage(),r)
                  },
                  onHighlightChanged: (value) {
                    splashController.isTab.value = value;
                  },
                  child: AnimatedContainer(
                    duration: 300.ms,
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: splashController.isTab.value
                        ? Get.width * .55
                        : Get.width * .6,
                    height: splashController.isTab.value ? 50.h : 55.h,
                    child: PhysicalModel(
                      shape: BoxShape.circle,
                      color: splashController.isTab.value
                          ? Colors.transparent
                          : Get.theme.disabledColor,
                      shadowColor: splashController.isTab.value
                          ? Colors.transparent
                          : Get.theme.primaryColor,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        alignment: Alignment.center,
                        height: 55.h,
                        width: Get.width * .6,
                        decoration: BoxDecoration(
                          color: splashController.isTab.value
                              ? Get.theme.disabledColor
                              : null,
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: splashController.isTab.value
                              ? null
                              : LinearGradient(
                                  colors: [
                                    Get.theme.primaryColor,
                                    AppColors.secondary,
                                  ],
                                ),
                        ),
                        child: TextAnimator(
                          // atRestEffect: WidgetRestingEffects.pulse(
                          //   effectStrength: .5,
                          // ),
                          atRestEffect: WidgetRestingEffects.bounce(
                            effectStrength: .5,
                            alignment: Alignment.center,
                          ),
                          incomingEffect: WidgetTransitionEffects
                              .incomingOffsetThenScaleAndStep(
                            duration: const Duration(milliseconds: 1000),
                          ),
                          'Get Start',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
