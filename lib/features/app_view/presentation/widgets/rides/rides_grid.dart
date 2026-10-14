import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../common/cloud.dart';
import 'ride_card.dart';

/// Bento grid: tall Autorickshaw card on the left, Cab on top right,
/// Bike + More below it. Heights use `.w` so the cards keep the design's
/// proportions when the screen gets wider.
class RidesGrid extends StatelessWidget {
  const RidesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final gap = 13.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 280.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(child: _AutoCard()),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 135.w, child: const _CabCard()),
                  SizedBox(height: gap),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(child: _BikeCard()),
                        SizedBox(width: gap),
                        const Expanded(child: _MoreCard()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AutoCard extends StatelessWidget {
  const _AutoCard();

  @override
  Widget build(BuildContext context) {
    final subtitle = AppTextStyles.autoCardSubtitle;

    return RideCard(
      image: AppAssets.autoRickshaw,
      imageHeight: 150.w,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFFEEF6FF),
          Color(0xFFFFF8EE),
          Color(0xFFCDCCCC),
        ],
        stops: const [
          0.4263, // 42.63%
          0.5267, // 52.67%
          1.0,    // 103.54% clamped to 1.0 (Flutter requires stops in 0.0 - 1.0 range)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(13.w, 14.w, 12.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NewBadge(),
            SizedBox(height: 12.w),
            Text('Autorickshaw', style: AppTextStyles.cardTitleLarge),
            SizedBox(height: 5.w),
            Text.rich(
              TextSpan(
                text: 'Book  Auto Rides\nwith Us ',
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.chevron_right_rounded, size: 14.r, color: AppColors.textSecondary),
                  ),
                ],
              ),
              style: subtitle,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: AppColors.badge,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text('NEW', style: AppTextStyles.badge),
    );
  }
}

class _CabCard extends StatelessWidget {
  const _CabCard();

  @override
  Widget build(BuildContext context) {
    return RideCard(
      image: AppAssets.cab,
      imageHeight: 87.w,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xB0ECF4FF),
          Color(0xB0FFF0D9),
          Color(0xB08E9299),
        ],
        stops: const [
          0.0009,
          // 0.09%
          0.5531,
          // 55.31%
          1.0,
          // CSS 117.28% is clamped to 1.0 (or normalized across stops)
        ],
      ),
      child: Stack(
        children: [
          // Sky clouds behind the title, positioned as in the design.
          Positioned(left: 12.w, top: 6.w, child: Cloud(width: 24.w)),
          Positioned(left: 88.w, top: 19.w, child: Cloud(width: 32.w, opacity: 0.9)),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 17.w, 12.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Affordable',
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 10.5.sp, color: AppColors.textHint),
                ),
                SizedBox(height: 1.w),
                Text('Cab', style: AppTextStyles.cardTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BikeCard extends StatelessWidget {
  const _BikeCard();

  @override
  Widget build(BuildContext context) {
    return RideCard(
      image: AppAssets.bike,
      imageHeight: 86.w,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFFF1F8FF),
          Color(0xFFFFEACB),
          Color(0xFFDDDDDD),
        ],
        stops: const [
          0.0,      // 0%
          0.7692,   // 76.92%
          0.9904,   // 99.04%
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 18.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text('Bike', style: AppTextStyles.cardTitle),
        ),
      ),
    );
  }
}

class _MoreCard extends StatelessWidget {
  const _MoreCard();

  @override
  Widget build(BuildContext context) {
    return RideCard(
      color: AppColors.moreCard,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 18.w, 0, 20.w),
        child: Column(
          children: [
            Text('More', style: AppTextStyles.cardTitle),
            const Spacer(),
            Image.asset(AppAssets.more, height: 35.w),
          ],
        ),
      ),
    );
  }
}