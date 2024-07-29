import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/view/onboarding/page/get_start_page.dart';
import 'package:football_fever/view/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../home/page/home_page.dart';
import '../data/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.find();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Get.theme.scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: splashController.onBoardingPageController,
              onPageChanged: (value) {
                splashController.currentIndexOnBoarding.value = value;
              },
              children: onBoardingData
                  .map((e) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(),
                          Obx(() {
                            return SizedBox(
                              width: Get.width > 600
                                  ? Get.width * .5
                                  : (Get.width * 0.8),
                              height: Get.height * .4,
                              child: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                      onBoardingData[splashController
                                              .currentIndexOnBoarding.value]
                                          .bgImage,
                                    ))),
                                  )
                                      .animate(
                                          onPlay: (controller) =>
                                              controller.repeat(reverse: true))
                                      .scaleXY(
                                          end: 1.0,
                                          begin: .9,
                                          duration: 1000.ms)
                                      .fadeIn(),
                                  Image.asset(
                                    onBoardingData[splashController
                                            .currentIndexOnBoarding.value]
                                        .imageUrl,
                                    key: ValueKey<int>(splashController
                                        .currentIndexOnBoarding.value),
                                    width: Get.width > 600
                                        ? Get.width * .5
                                        : (Get.width * 0.8),
                                    height: Get.height * .4,
                                    fit: BoxFit.fill,
                                    // fit: BoxFit.contain,
                                  ).animate().fadeIn(delay: 200.ms),
                                ],
                              ),
                            );
                          }),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: TextAnimator(
                              incomingEffect:
                                  WidgetTransitionEffects.incomingScaleDown(
                                duration: const Duration(milliseconds: 1000),
                              ),
                              e.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 22.sp,
                                  ),
                            ),
                          ),
                          8.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.w),
                            child: TextAnimator(
                              incomingEffect: WidgetTransitionEffects
                                  .incomingSlideInFromRight(
                                      delay: const Duration(milliseconds: 0)),
                              // overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              e.detail,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    height: 1.8,
                                    color:
                                        Get.theme.brightness == Brightness.dark
                                            ? Colors.white54
                                            : Colors.black54,
                                  ),
                            ),
                          ).animate().fadeIn(
                                delay: 300.ms,
                              ),
                          const Spacer(),
                        ],
                      ))
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            height: 120.h,
            width: Get.width,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.offAll(
                      const HomePage(),
                      duration: 400.ms,
                      transition: Transition.fadeIn,
                    );
                  },
                  child: Text(
                    'Skip',
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: splashController.onBoardingPageController,
                  count: onBoardingData.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.h,
                    radius: 6.r,
                    activeDotColor: Get.theme.primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    int value = splashController.currentIndexOnBoarding.value;
                    if (value < 1) {
                      value++;
                      splashController.currentIndexOnBoarding.value = value;
                      splashController.onBoardingPageController.animateToPage(
                          value,
                          duration: 400.ms,
                          curve: Curves.linearToEaseOut);
                    } else {
                      Get.offAll(
                        const HomePage(),
                        duration: 400.ms,
                        transition: Transition.fadeIn,
                      );
                    }
                  },
                  child: Obx(() {
                    return Text(
                      splashController.currentIndexOnBoarding.value < 1
                          ? 'Next'
                          : 'Done',
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Get.theme.primaryColor,
                      ),
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
