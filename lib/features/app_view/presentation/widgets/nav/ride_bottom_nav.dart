import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/ride_nav_item.dart';

/// Bottom bar with vehicle tabs. The warm highlight with its divider line
/// slides to the selected tab; the selected tab shows only a larger vehicle,
/// the others show vehicle + label (as in the design).
class RideBottomNav extends StatelessWidget {
  const RideBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<RideNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 6))],
      ),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SizedBox(
        height: 73.r,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // First tab is narrower (75 in the design), the rest share the space.
            final firstWidth = 75.w;
            final otherWidth = (constraints.maxWidth - firstWidth) / (items.length - 1);
            double widthOf(int i) => i == 0 ? firstWidth : otherWidth;
            double leftOf(int i) => i == 0 ? 0 : firstWidth + otherWidth * (i - 1);

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: _duration,
                  curve: _curve,
                  top: 0,
                  bottom: 0,
                  left: leftOf(selectedIndex),
                  width: widthOf(selectedIndex),
                  child: const _SelectionIndicator(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < items.length; i++)
                      SizedBox(
                        width: widthOf(i),
                        child: _NavTab(
                          item: items[i],
                          selected: i == selectedIndex,
                          onTap: () => onSelected(i),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Warm gradient block with the thin divider line on its right edge.
class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.surfaceWarm, Color(0xFFFFFBF6)],
        ),
        border: Border(right: BorderSide(color: Color(0xFFCBCBCF), width: 0.8)),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({required this.item, required this.selected, required this.onTap});

  final RideNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showLabel = !selected && item.label != null;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: RideBottomNav._duration,
            curve: RideBottomNav._curve,
            height: selected ? 60.r : 40.r,
            child: Image.asset(item.image),
          ),
          AnimatedSize(
            duration: RideBottomNav._duration,
            curve: RideBottomNav._curve,
            child: showLabel
                ? Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(item.label!, style: AppTextStyles.navLabel),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
