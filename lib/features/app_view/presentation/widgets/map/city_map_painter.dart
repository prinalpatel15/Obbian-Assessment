import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Stylised city map drawn in code (the reference map is covered by overlays,
/// so it cannot be cropped). Coordinates are in the 375x430 design frame and
/// scaled to the real size.
class CityMapPainter extends CustomPainter {
  const CityMapPainter();

  static const _frame = Size(375, 430);

  @override
  void paint(Canvas canvas, Size size) {
    // Uniform scale (cover) keeps trees and blocks from turning oval.
    final scale = math.max(size.width / _frame.width, size.height / _frame.height);
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(
      (size.width - _frame.width * scale) / 2,
      (size.height - _frame.height * scale) / 2,
    );
    canvas.scale(scale);

    canvas.drawRect(Offset.zero & _frame, Paint()..color = AppColors.mapLand);
    _paintStreetGrid(canvas);
    _paintWater(canvas);
    _paintLandmarks(canvas);
    _paintParks(canvas);
    _paintRailway(canvas);
    _paintMainRoad(canvas);

    canvas.restore();
  }

  void _paintStreetGrid(Canvas canvas) {
    canvas.save();
    canvas.translate(_frame.width / 2, _frame.height / 2);
    canvas.rotate(-0.16);
    canvas.translate(-_frame.width / 2, -_frame.height / 2);

    const step = 34.0;
    final block = Paint();
    final random = math.Random(7);
    for (var x = -80.0; x < _frame.width + 80; x += step) {
      for (var y = -80.0; y < _frame.height + 80; y += step * 0.8) {
        block.color = random.nextDouble() > 0.35 ? AppColors.mapBlock : AppColors.mapBlockLight;
        final rect = Rect.fromLTWH(x + 3, y + 3, step - 6, step * 0.8 - 6);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), block);

        // Inner lots for a denser, more "drawn" look.
        if (random.nextDouble() > 0.5) {
          final lot = Paint()..color = AppColors.mapLand.withValues(alpha: 0.8);
          canvas.drawLine(rect.topCenter, rect.bottomCenter, lot..strokeWidth = 1);
        }
      }
    }

    final minor = Paint()
      ..color = AppColors.mapRoad
      ..strokeWidth = 3;
    final major = Paint()
      ..color = AppColors.mapRoad
      ..strokeWidth = 6;
    var i = 0;
    for (var x = -80.0; x < _frame.width + 80; x += step, i++) {
      canvas.drawLine(Offset(x, -100), Offset(x, _frame.height + 100), i % 3 == 0 ? major : minor);
    }
    i = 0;
    for (var y = -80.0; y < _frame.height + 80; y += step * 0.8, i++) {
      canvas.drawLine(Offset(-100, y), Offset(_frame.width + 100, y), i % 3 == 1 ? major : minor);
    }
    canvas.restore();

    // A couple of diagonal avenues break the grid like in the reference.
    canvas.drawLine(const Offset(0, 120), const Offset(375, 300), major);
    canvas.drawLine(const Offset(180, 430), const Offset(330, 170), minor..strokeWidth = 4);
  }

  void _paintWater(Canvas canvas) {
    final water = Path()
      ..moveTo(0, 300)
      ..lineTo(60, 335)
      ..lineTo(130, 352)
      ..lineTo(205, 430)
      ..lineTo(0, 430)
      ..close();
    canvas.drawPath(water, Paint()..color = AppColors.mapWater);

    final canal = Paint()
      ..color = AppColors.mapWaterDeep
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(0, 372), const Offset(110, 430), canal);
    canvas.drawLine(const Offset(250, 430), const Offset(375, 352), canal..strokeWidth = 9);
    canvas.drawLine(const Offset(300, 430), const Offset(375, 388), canal..color = AppColors.mapWater);
  }

  void _paintLandmarks(Canvas canvas) {
    void block(Rect rect, Color color) => canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(2)),
          Paint()..color = color,
        );

    block(const Rect.fromLTWH(112, 85, 58, 46), AppColors.mapAmber);
    block(const Rect.fromLTWH(122, 94, 38, 28), AppColors.mapBlockLight);
    block(const Rect.fromLTWH(140, 63, 30, 24), AppColors.mapTeal);
    block(const Rect.fromLTWH(155, 20, 46, 32), AppColors.mapWater);
    block(const Rect.fromLTWH(196, 118, 38, 34), AppColors.mapBlockLight);
    block(const Rect.fromLTWH(222, 70, 34, 22), AppColors.mapAmber);
    block(const Rect.fromLTWH(248, 100, 44, 38), AppColors.mapBlockLight);
    block(const Rect.fromLTWH(264, 166, 13, 13), AppColors.mapTeal);
    block(const Rect.fromLTWH(118, 96, 7, 7), AppColors.mapTeal);
    block(const Rect.fromLTWH(330, 236, 18, 14), AppColors.mapWater);

    // Bright landmark circle top-left.
    canvas.drawCircle(const Offset(92, 6), 22, Paint()..color = const Color(0xFFF7E3A1));
    canvas.drawCircle(const Offset(92, 6), 12, Paint()..color = AppColors.mapBlockLight);
  }

  void _paintParks(Canvas canvas) {
    final park = Paint()..color = AppColors.mapPark;
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-10, 160, 70, 95), const Radius.circular(18)),
      park,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-10, 20, 34, 40), const Radius.circular(10)),
      park,
    );

    const trees = [Offset(50, 168), Offset(27, 222), Offset(242, 216), Offset(108, 8), Offset(8, 175)];
    final shadow = Paint()..color = Colors.black.withValues(alpha: 0.12);
    final tree = Paint()..color = AppColors.mapTree;
    final trunk = Paint()
      ..color = const Color(0xFF7A5230)
      ..strokeWidth = 1.5;
    for (final t in trees) {
      canvas.drawLine(t, t.translate(0, 7), trunk);
      canvas.drawOval(Rect.fromCenter(center: t.translate(1, 8), width: 12, height: 4), shadow);
      canvas.drawCircle(t, 6.5, tree);
    }
    canvas.drawCircle(const Offset(58, 180), 3, Paint()..color = const Color(0xFFF0883E));
  }

  void _paintRailway(Canvas canvas) {
    const from = Offset(318, 95);
    const to = Offset(240, 385);
    canvas.drawLine(from, to, Paint()
      ..color = AppColors.mapRail
      ..strokeWidth = 5);

    final sleeper = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    final dir = (to - from) / (to - from).distance;
    final normal = Offset(-dir.dy, dir.dx) * 2.5;
    for (var d = 0.0; d < (to - from).distance; d += 3.5) {
      final p = from + dir * d;
      canvas.drawLine(p - normal, p + normal, sleeper);
    }
  }

  void _paintMainRoad(Canvas canvas) {
    final road = Path()
      ..moveTo(170, -10)
      ..cubicTo(110, 90, 70, 150, 75, 215)
      ..cubicTo(80, 260, 140, 300, 190, 345)
      ..cubicTo(215, 370, 235, 400, 248, 440);

    canvas.drawPath(road, Paint()
      ..color = Colors.white
      ..strokeWidth = 11
      ..style = PaintingStyle.stroke);
    canvas.drawPath(road, Paint()
      ..color = AppColors.mapMainRoad
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke);

    final dash = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    for (final metric in road.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 16) {
        canvas.drawPath(metric.extractPath(d, d + 5), dash);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CityMapPainter oldDelegate) => false;
}
