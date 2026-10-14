import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Frosted circular play button shown on video cards.
class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  static double get size => 34.r;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.2),
            border: Border.all(color: Colors.white, width: 1.8.r),
          ),
          child: Icon(Icons.play_arrow_rounded, size: 20.r, color: Colors.white),
        ),
      ),
    );
  }
}
