import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xfff59420);
  static const Color secondary = Color(0xFFffd970);
  static const Color white = Color(0xffFEFEFE);
  static const Color dark = Color(0xff111111);
  static const Color blackLight = Color.fromRGBO(74, 74, 101, 1);
  static const Color whiteLight = Color(0xffE3E7EC);
  static const Color green = Color(0xff00C566);
  static const Color red = Color(0xffE53935);
  static const Color yellow = Color(0xffFACC15);
  static MaterialColor primaryMaterialColor =
      getMaterialColorFromColor(AppColors.primary);

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
