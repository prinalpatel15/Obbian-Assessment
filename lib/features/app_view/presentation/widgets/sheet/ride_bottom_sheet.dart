import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Draggable sheet over the map. Rests at [initialSize] (the design
/// position), can be pulled down to [minSize] to see more map, or up to
/// [maxSize] (just under the status bar). The handle stays pinned while the
/// content scrolls, and dragging anywhere on the sheet moves it.
class RideBottomSheet extends StatelessWidget {
  const RideBottomSheet({
    super.key,
    required this.initialSize,
    required this.minSize,
    required this.maxSize,
    required this.child,
    this.controller,
  });

  final double initialSize;
  final double minSize;
  final double maxSize;
  final Widget child;
  final DraggableScrollableController? controller;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(22.r);

    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      snap: true,
      snapSizes: [
        if (initialSize > minSize && initialSize < maxSize) initialSize,
      ],
      builder: (context, scrollController) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: radius),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, -2)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: radius),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                // Rounded: fractional extents trip Flutter's sliver geometry
                // assert (layoutExtent > paintExtent by a rounding error).
                delegate: _HandleHeader(height: 33.h.roundToDouble()),
              ),
              SliverToBoxAdapter(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _HandleHeader extends SliverPersistentHeaderDelegate {
  _HandleHeader({required this.height});

  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: AppColors.background,
      child: Padding(
        padding: EdgeInsets.only(top: 13.h),
        child: const Align(alignment: Alignment.topCenter, child: SheetHandle()),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HandleHeader oldDelegate) => oldDelegate.height != height;
}

/// Grey drag handle on top of the bottom sheet.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.handle,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}
