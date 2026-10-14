import 'package:flutter/material.dart';

/// Soft, flat-bottomed illustration cloud (white top, warm grey base) used
/// in the sky of the ride cards. Size it with width; height follows.
class Cloud extends StatelessWidget {
  const Cloud({super.key, required this.width, this.opacity = 0.95});

  final double width;
  final double opacity;

  static const _aspect = 2.4;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: CustomPaint(size: Size(width, width / _aspect), painter: const _CloudPainter()),
    );
  }
}

class _CloudPainter extends CustomPainter {
  const _CloudPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final shape = Path()
      ..addRRect(RRect.fromLTRBR(0, h * 0.5, w, h, Radius.circular(h * 0.25)))
      ..addOval(Rect.fromCircle(center: Offset(w * 0.3, h * 0.55), radius: h * 0.32))
      ..addOval(Rect.fromCircle(center: Offset(w * 0.55, h * 0.42), radius: h * 0.42))
      ..addOval(Rect.fromCircle(center: Offset(w * 0.76, h * 0.6), radius: h * 0.28));

    // Faint drop shadow so the cloud lifts off the pale sky.
    canvas.drawPath(
      shape.shift(Offset(0, h * 0.08)),
      Paint()
        ..color = const Color(0x1F000000)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, h * 0.08),
    );

    canvas.drawPath(
      shape,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFEFEBE5), Color(0xFFD8D1C6)],
          stops: [0, 0.6, 1],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(covariant _CloudPainter oldDelegate) => false;
}
