import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_colors.dart';

/// Rounded card shell shared by every tile in the Rides grid.
///
/// The [image] sits at the bottom and fades into the card background at its
/// top edge, so the illustration blends with the sky gradient.
class RideCard extends StatelessWidget {
  const RideCard({
    super.key,
    required this.child,
    this.image,
    this.imageHeight,
    this.gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.skyTop, AppColors.sandBottom],
    ),
    this.color,
    this.onTap,
  });

  final Widget child;
  final String? image;
  final double? imageHeight;
  final Gradient? gradient;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color,
        gradient: color == null ? gradient : null,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap ?? () {},
            child: Stack(
              children: [
                if (image != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: imageHeight,
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0, 0.25],
                      ).createShader(bounds),
                      child: Image.asset(image!, fit: BoxFit.cover, alignment: Alignment.bottomCenter),
                    ),
                  ),
                Positioned.fill(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
