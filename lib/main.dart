import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/themes/theme.dart';
import 'package:football_fever/common/controller/theme_controller.dart';
import 'package:football_fever/common/dependency/initial_binding.dart';
import 'package:get/get.dart';
import 'view/splash/page/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) => GetMaterialApp(
        initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        theme: AppThemes.main(),
        darkTheme: AppThemes.main(isDark: true),
        themeMode:
            themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
        home: const SplashPage(),
      ),
    );
  }
}
