import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/media_card_item.dart';
import 'play_button.dart';

/// Rounded image card. With a [MediaCardItem.title] it becomes the
/// "Neighborhood" video card: the photo sits on top, a blurred copy fills the
/// rest and the caption reads over a dark bottom gradient.
class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.item,
    this.borderRadius,
    this.photoHeight,
    this.onTap,
  });

  final MediaCardItem item;
  /// Defaults to 14.r.
  final double? borderRadius;

  /// Height of the sharp photo area; the rest is a blurred extension.
  /// Null means the photo covers the whole card.
  final double? photoHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (photoHeight != null) ...[
              Image.asset(item.image, fit: BoxFit.cover, alignment: Alignment.bottomCenter),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: photoHeight,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.8, 1],
                  ).createShader(bounds),
                  child: SvgPicture.asset(item.image, fit: BoxFit.cover, alignment: Alignment.topLeft),
                ),
              ),
            ] else
              Image.asset(item.image, fit: BoxFit.cover),
            if (item.isVideo && photoHeight != null)
              // Same spot on every card: centred horizontally, at the
              // design's 97.5/166 of the photo area.
              Positioned(
                left: 0,
                right: 0,
                top: photoHeight! * (97.5 / 166) - PlayButton.size / 2,
                child: const Center(child: PlayButton()),
              ),
            if (item.title != null) ...[
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0x80000000)],
                    stops: [0.55, 1],
                  ),
                ),
              ),
              Positioned(
                left: 13.w,
                right: 10.w,
                bottom: 22.w,
                child: Text(item.title!, style: AppTextStyles.overlayTitle),
              ),
            ],
            InkWell(onTap: onTap ?? () {}),
          ],
        ),
      ),
    );
  }
}
