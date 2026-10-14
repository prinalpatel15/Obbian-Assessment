import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../common/glass_container.dart';

class LocationChip extends StatelessWidget {
  const LocationChip({super.key, required this.city, this.onProfileTap});

  final String city;
  final VoidCallback? onProfileTap;

  /// `.r` (not `.h`) so it never squashes the text on short/landscape screens.
  static double get height => 50.r;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.fromLTRB(16.w, 8.r, 16.w, 8.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height - 10.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current location', style: AppTextStyles.label),
                  SizedBox(height: 2.r),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.location, height: 16.r),
                      SizedBox(width: 7.w),
                      Text(city, style: AppTextStyles.labelBold),
                    ],
                  ),
                ],
              ),
            ),
            _ProfileButton(onTap: onProfileTap),
          ],
        ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.square(
        dimension: 28.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(AppAssets.user, height: 20.r),
            Positioned(
              top: 1.2.r,
              right: 7.r,
              child: CircleAvatar(radius: 3.r, backgroundColor: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
