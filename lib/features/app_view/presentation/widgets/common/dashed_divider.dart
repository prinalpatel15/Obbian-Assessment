import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({
    super.key,
    this.color = AppColors.divider,
    this.dashWidth = 3,
    this.gap = 2,
  });

  final Color color;

  /// Design values, scaled with `.w` when painting.
  final double dashWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: CustomPaint(painter: _DashPainter(color, dashWidth.w, gap.w)),
    );
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color, this.dashWidth, this.gap);

  final Color color;
  final double dashWidth;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height;
    final y = size.height / 2;
    for (var x = 0.0; x < size.width; x += dashWidth + gap) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter old) =>
      old.color != color || old.dashWidth != dashWidth || old.gap != gap;
}
