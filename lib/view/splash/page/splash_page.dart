import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:football_fever/appearance/image_const.dart';
import 'package:get/get.dart';

import '../../../common/clipper/diagonal_clipper.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFFffd04f),
                  Color(0xFFffdb79),
                  Color(0xFFffe7a4),
                  Color(0xFFffecba),
                  Color(0xFFfff7e2),
                  Color(0xFFfffcf5),
                  Colors.white,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                splashPlayer,
                height: Get.height * .5,
                fit: BoxFit.contain,
              ).animate().fadeIn(
                    delay: 300.ms,
                    duration: 700.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Get.height * .15),
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: DiagonalClipper(),
              child: Container(
                height: Get.height * .5,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: RotationTransition(
                  turns: Get.width > 600
                      ? const AlwaysStoppedAnimation(-25 / 360)
                      : Get.height < 800
                          ? const AlwaysStoppedAnimation(-32 / 360)
                          : const AlwaysStoppedAnimation(-37 / 360),
                  child: Image.asset(appNameLogo).animate().fadeIn(
                        delay: 500.ms,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                      ),
                ),
              )
                  .animate()
                  .shimmer(color: Get.theme.primaryColor, duration: 600.ms),
            ),
          )
        ],
      ),
    );
  }
}
