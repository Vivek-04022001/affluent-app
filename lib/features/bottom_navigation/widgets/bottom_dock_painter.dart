import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Bottom dock with a circular cradle for the center FAB and
/// smooth ramps that match the circle's tangent (C¹ continuity).
class SmoothDockPainter extends CustomPainter {
  SmoothDockPainter({
    this.fillColor = const Color(0xFF1F2733),
    this.strokeColor = const Color(0x334A90E2),
    this.strokeWidth = 1.0,

    // Geometry
    required this.fabDiameter, // your FAB size (e.g., 64)
    this.clearance = 6, // visual gap around FAB inside cradle
    this.sink = 10, // how much the circle sinks below the top line
    this.rampWidth = 56, // horizontal length of each ramp
    this.rampRise = 10, // ramps sit this much above the top baseline
    this.thetaDeg =
        48, // half-angle of the arc (controls how wide the cradle feels)
    this.topInset =
        6, // bring the whole shape slightly below y=0 so stroke is visible
  });

  // Painting
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  // Params you’ll tune
  final double fabDiameter;
  final double clearance; // extra radius so the FAB doesn’t touch the edges
  final double sink; // how “deep” the cradle sits below the top
  final double rampWidth; // width of curved ramps on each side
  final double rampRise; // ramps sit above baseline for that wavy feel
  final double thetaDeg; // arc half-angle
  final double topInset; // top margin for stroke visibility

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // --- 1) Define the baseline and center geometry -------------------------
    final baseY = topInset; // nominal top baseline
    final leftFlatY = baseY - rampRise; // left flat height (raised)
    final rightFlatY = baseY - rampRise; // right flat height (raised)

    final cx = w / 2; // center X
    final r = fabDiameter / 2 + clearance; // cradle radius
    final theta = (thetaDeg.clamp(20, 70)) * math.pi / 180.0;

    // We place the circle so that its top is at baseY - sink (sinks into the bar).
    // Top of circle = cy - r  →  cy = baseY - sink + r
    final cy = baseY - sink + r;

    // Points where the circle meets the ramps (at angle ±theta from vertical)
    // Parametric circle (center cx,cy): x = cx + r*sin(a), y = cy - r*cos(a)
    final leftArcPt = Offset(
      cx - r * math.sin(theta),
      cy - r * math.cos(theta),
    );
    final rightArcPt = Offset(
      cx + r * math.sin(theta),
      cy - r * math.cos(theta),
    );

    // Tangent direction at those points is perpendicular to radius.
    // Unit tangent vector at angle θ from vertical:
    //   t = ( cosθ,  sinθ ) if we traverse left→right along the top arc.
    final tx = math.cos(theta);
    final ty = math.sin(theta);

    // --- 2) Build the path ---------------------------------------------------
    final path = Path();

    // Bottom-left
    path.moveTo(0, h);

    // Left wall up to raised flat
    path.lineTo(0, leftFlatY);

    // Flat until ramp begins
    final rampLeftStartX = (leftArcPt.dx - rampWidth).clamp(0.0, w);
    path.lineTo(rampLeftStartX, leftFlatY);

    // --- Left ramp (Bezier) into the circle with tangent match --------------
    // Start (p0)
    final p0 = Offset(rampLeftStartX, leftFlatY);
    // End (p3) is the circle point
    final p3 = leftArcPt;

    // Control handles:
    // - p1: leave horizontally from p0 (smooth off the flat)
    // - p2: back off from p3 along the CIRCLE TANGENT so slope matches
    final handle = rampWidth * 0.6; // length of Bezier handles; tweak 0.5–0.8
    final p1 = Offset(p0.dx + handle * 0.6, p0.dy); // mostly horizontal
    final p2 = Offset(
      p3.dx - handle * tx,
      p3.dy - handle * ty,
    ); // along tangent

    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);

    // --- Circular cradle across the center ----------------------------------
    // We draw a circular arc from leftArcPt to rightArcPt using the same radius.
    // This guarantees a perfect circle under the FAB.
    path.arcToPoint(
      rightArcPt,
      radius: Radius.circular(r),
      clockwise: false, // go "downward" then up to the right point
    );

    // --- Right ramp (mirror) out of the circle with tangent match -----------
    final rampRightEndX = (rightArcPt.dx + rampWidth).clamp(0.0, w);
    final q0 = rightArcPt;
    final q3 = Offset(rampRightEndX, rightFlatY);

    // p1 along tangent (forward) and p2 horizontal into flat
    final q1 = Offset(q0.dx + handle * tx, q0.dy + handle * ty);
    final q2 = Offset(q3.dx - handle * 0.6, q3.dy);

    path.cubicTo(q1.dx, q1.dy, q2.dx, q2.dy, q3.dx, q3.dy);

    // Flat to right edge, then down to bottom-right and close
    path.lineTo(w, rightFlatY);
    path.lineTo(w, h);
    path.close();

    // --- 3) Paint ------------------------------------------------------------
    final fill = Paint()..color = fillColor;
    canvas.drawPath(path, fill);

    if (strokeWidth > 0) {
      final stroke =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = strokeColor;
      canvas.drawPath(path, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant SmoothDockPainter old) {
    return fillColor != old.fillColor ||
        strokeColor != old.strokeColor ||
        strokeWidth != old.strokeWidth ||
        fabDiameter != old.fabDiameter ||
        clearance != old.clearance ||
        sink != old.sink ||
        rampWidth != old.rampWidth ||
        rampRise != old.rampRise ||
        thetaDeg != old.thetaDeg ||
        topInset != old.topInset;
  }
}
