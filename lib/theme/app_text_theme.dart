import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart'; // Import ScreenUtil

class AppTextTheme {
  static TextTheme darkTextTheme = GoogleFonts.interTextTheme(
    TextTheme(
      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32.sp, // Responsive font size
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    ),
  );
}
