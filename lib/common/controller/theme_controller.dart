import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  late ThemePreferences _preferences;

  ThemeController() {
    _preferences = ThemePreferences();
    getPreferences();
  }

  void setTheme(bool value) {
    isDark.value = value;
    _preferences.setTheme(value);
  }

  void getPreferences() async {
    isDark.value = await _preferences.getTheme();
  }
}

class ThemePreferences {
  static const themeKey = "themeKey";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(themeKey, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeKey) ?? false;
  }
}
