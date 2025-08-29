import 'package:flutter/material.dart';

class DockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F1B2B), Color(0xFF0C1320)],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Constants for the curve shape
    const dipWidth = 120.0; // Width of the dip for the icon
    const dipDepth = 50.0; // Depth of the dip
    const radius = 24.0; // Corner radius
    const curveHeight = 20.0; // Height of the upward curve

    final path =
        Path()
          ..moveTo(0, size.height - 10) // Start at the bottom-left corner
          ..lineTo(0, radius) // Draw a vertical line to the rounded corner
          ..quadraticBezierTo(0, 0, radius, 0) // Top-left rounded corner
          ..lineTo(
            size.width / 2 - dipWidth / 2 - curveHeight,
            0,
          ) // Move to the start of the upward curve
          // Upward curve before the dip
          ..quadraticBezierTo(
            size.width / 2 - dipWidth / 2,
            0 - curveHeight,
            size.width / 2 - dipWidth / 2 + curveHeight,
            0,
          )
          // Dip for the icon
          ..cubicTo(
            size.width / 2 - dipWidth * 0.2,
            0,
            size.width / 2 - dipWidth * 0.2,
            dipDepth,
            size.width / 2,
            dipDepth,
          )
          ..cubicTo(
            size.width / 2 + dipWidth * 0.2,
            dipDepth,
            size.width / 2 + dipWidth * 0.2,
            0,
            size.width / 2 + dipWidth / 2 - curveHeight,
            0,
          )
          // Downward curve after the dip
          ..quadraticBezierTo(
            size.width / 2 + dipWidth / 2,
            0 - curveHeight,
            size.width / 2 + dipWidth / 2 + curveHeight,
            0,
          )
          ..lineTo(size.width - radius, 0) // Move to the top-right corner
          ..quadraticBezierTo(
            size.width,
            0,
            size.width,
            radius,
          ) // Top-right rounded corner
          ..lineTo(
            size.width,
            size.height,
          ) // Draw a vertical line to the bottom-right corner
          ..close(); // Close the path

    canvas.drawPath(path, paint); // Draw the path on the canvas
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
