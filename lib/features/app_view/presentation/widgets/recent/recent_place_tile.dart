import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/recent_place.dart';
import '../common/dashed_divider.dart';

class RecentPlaceTile extends StatefulWidget {
  const RecentPlaceTile({super.key, required this.place, this.onTap});

  final RecentPlace place;
  final VoidCallback? onTap;

  @override
  State<RecentPlaceTile> createState() => _RecentPlaceTileState();
}

class _RecentPlaceTileState extends State<RecentPlaceTile> {
  late bool _isFavorite = widget.place.isFavorite;

  @override
  Widget build(BuildContext context) {
    final place = widget.place;

    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
            child: Row(
              children: [
                SizedBox(
                  width: 38.w,
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAssets.time),
                      SizedBox(height: 6.h),
                      Text(place.distance, style: AppTextStyles.caption.copyWith(fontSize: 10.sp)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.title, style: AppTextStyles.placeTitle),
                      SizedBox(height: 7.h),
                      Text(
                        place.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 48.w),
                GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: SvgPicture.asset(
                    AppAssets.heart,
                    color: _isFavorite ? AppColors.pin : AppColors.iconMuted,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 58.w, right: 20.w),
            child: const DashedDivider(),
          ),
        ],
      ),
    );
  }
}
