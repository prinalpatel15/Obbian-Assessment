import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import 'location_chip.dart';
import 'search_panel.dart';

/// Full-screen map layer behind the bottom sheet, with the location chip,
/// pin and search panel. Positions follow the 375x812 design frame;
/// [topInset] pushes everything below the status bar.
class MapHeader extends StatelessWidget {
  const MapHeader({super.key, required this.city, this.topInset = 0});

  final String city;
  final double topInset;

  /// Where the sheet's top edge rests initially (below the status bar).
  static double get sheetTop => 412.h;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -170,
          left: 0,
          right: 0,
          child: Image.asset(AppAssets.bg, fit: BoxFit.fill),
        ),
        Positioned(
          top: topInset + 16.h,
          left: 16.w,
          right: 16.w,
          child: LocationChip(city: city),
        ),
        Positioned(
          top: topInset + 238.h,
          left: 16.w,
          right: 16.w,
          child: GradientEdgeBorder(radius: 32.r, child: const SearchPanel()),
        ),
      ],
    );
  }
}

// Example usage
class GradientEdgeBorder extends StatelessWidget {
  final Widget child;
  final double radius;

  const GradientEdgeBorder({super.key, required this.child, this.radius = 32});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              child,
              // Border is painted separately; no solid outline.
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _GradientEdgePainter(radius: radius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientEdgePainter extends CustomPainter {
  final double radius;

  _GradientEdgePainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const thickness = 2.1;
    final r = radius;

    // Top horizontal gradient
    final topPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..shader = const LinearGradient(
        colors: [Colors.white, Colors.white, Colors.white, Color(0x00FFFFFF)],
        stops: [0.0, 0.3, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(r, 0, size.width - 2 * r, size.height));

    // Bottom horizontal gradient
    final bottomPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.white,
          Colors.amber,
          Color(0x094790C7),
          Colors.white.withOpacity(0.5),
          Colors.white,
        ],
        stops: [0.0005, 0.1, 0.7, 0.8, 0.9, 1.0],
      ).createShader(Rect.fromLTWH(r, 0, size.width - 2 * r, size.height));

    // Left vertical gradient
    final leftVerticalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.white,
          Colors.white,
          Color(0x094790C7),
          Color(0x00FFFFFF),
        ],
        stops: [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, r, 1, size.height - 2 * r));

    // Right vertical gradient
    final rightVerticalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x094790C7),
          Color(0x00FFFFFF),
          Colors.white,
          Colors.white,
          Colors.white,
        ],
        stops: [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(size.width - 1, r, 1, size.height - 2 * r));

    // Corner border paint
    final cornerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..color = Colors.white;

    const cornerGap = 0;

    // Top horizontal edge
    canvas.drawLine(
      Offset(r + cornerGap, 0.7),
      Offset(size.width - r - cornerGap, 0.7),
      topPaint,
    );

    // Bottom horizontal edge
    canvas.drawLine(
      Offset(r + cornerGap, size.height - 0.7),
      Offset(size.width - r - cornerGap, size.height - 0.7),
      bottomPaint,
    );

    // Left vertical edge
    canvas.drawLine(
      Offset(0.7, r),
      Offset(0.7, size.height - r),
      leftVerticalPaint,
    );

    // Right vertical edge
    canvas.drawLine(
      Offset(size.width - 0.7, r),
      Offset(size.width - 0.7, size.height - r),
      rightVerticalPaint,
    );

    // Top-left rounded corner border
    canvas.drawArc(
      Rect.fromLTWH(0.7, 0.7, 2 * r, 2 * r),
      math.pi,
      math.pi / 2,
      false,
      cornerPaint,
    );

    // Bottom-right rounded corner border
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - 2 * r - 0.7,
        size.height - 2 * r - 0.7,
        2 * r,
        2 * r,
      ),
      0,
      math.pi / 2,
      false,
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientEdgePainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}
