import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:football_fever/view/onboarding/page/onboarding_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(const OnboardingPage(),
          transition: Transition.fadeIn, duration: 500.ms);
    });
    super.onInit();
  }

  ///onboarding
  final onBoardingPageController = PageController();
  RxInt currentIndexOnBoarding = RxInt(0);
}
