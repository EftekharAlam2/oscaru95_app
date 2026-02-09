import 'package:flutter/material.dart';
import 'package:oscaru95/gen/colors.gen.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFFFF7A01, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFFF7A01), //10%
      100: Color(0xFFFF7A01), //20%
      200: Color(0xFFFF7A01), //30%
      300: Color(0xFFFF7A01), //40%
      400: Color(0xFFFF7A01), //50%
      500: Color(0xFFFF7A01), //60%
      600: Color(0xFFFF7A01), //70%
      700: Color(0xFFFF7A01), //80%
      800: Color(0xFFFF7A01), //80%
      900: Color(0xFFFF7A01), //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
        // primaryColor: AppColors.cFF7A01,
        // primarySwatch: CustomTheme.kToDark,
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        useMaterial3: true);
  }
}
