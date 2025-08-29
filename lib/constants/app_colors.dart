import 'package:flutter/material.dart';

class AppColors {
  // yellow, dark blue, yellow , white, gold, beginner blue, super green
  static const Color yellow = Color(0xffC1A953);
  static const Color darkBlue = Color(0xFF04101E);
  static const Color darkYellow = Color(0xFFD4A849);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gold = Color(0xFFC1A953);
  static const Gradient blueGradient = LinearGradient(
    colors: [Color(0xFF5ED6E6), Color(0xff00515c)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xFF49D483), Color(0xFF49D483)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Color darkBlueSecondary = Color(0xFF38485A);
  static const Color purple = Color(0xFF704EF4);
}
