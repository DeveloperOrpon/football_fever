import 'package:football_fever/common/controller/theme_controller.dart';
import 'package:football_fever/view/following/controller/following_controller.dart';
import 'package:football_fever/view/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

import '../../view/home/controller/home_controller.dart';
import '../../view/match/controller/match_controller.dart';
import '../../view/news/controller/news_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<FollowingController>(
      () => FollowingController(),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
    Get.lazyPut<MatchController>(
      () => MatchController(),
    );
  }
}
