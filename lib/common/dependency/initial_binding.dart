import 'package:football_fever/common/controller/theme_controller.dart';
import 'package:football_fever/view/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
