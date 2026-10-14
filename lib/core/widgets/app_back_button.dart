import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

/// Round back button shared by every screen. Uses `maybePop`, so a screen's
/// PopScope (e.g. web history in Web View) still gets the first say.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed, this.size, this.translucent = false});

  final VoidCallback? onPressed;
  final double? size;

  /// Frosted look for use on top of the map.
  final bool translucent;

  @override
  Widget build(BuildContext context) {
    final dimension = size ?? 36.r;

    return Material(
      color: translucent ? AppColors.glass : AppColors.surface,
      shape: CircleBorder(
        side: translucent ? const BorderSide(color: AppColors.glassBorder) : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.maybePop(context),
        child: SizedBox.square(
          dimension: dimension,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16.r,
            color: AppColors.textPrimary,
            semanticLabel: MaterialLocalizations.of(context).backButtonTooltip,
          ),
        ),
      ),
    );
  }
}
