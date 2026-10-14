import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../data/app_view_mock_data.dart';
import 'widgets/map/locate_button.dart';
import 'widgets/map/map_header.dart';
import 'widgets/nav/ride_bottom_nav.dart';
import 'widgets/sheet/ride_bottom_sheet.dart';
import 'widgets/sheet/ride_sheet_content.dart';

/// Native ride-booking home: fixed map with search on top, a draggable
/// bottom sheet with recent places, rides, explore and neighborhood
/// sections, and the vehicle tab bar.
class AppViewScreen extends StatefulWidget {
  const AppViewScreen({super.key});

  @override
  State<AppViewScreen> createState() => _AppViewScreenState();
}

class _AppViewScreenState extends State<AppViewScreen> {
  int _selectedTab = 0;

  /// Current sheet size as a fraction of the body height. Drives the locate
  /// button without rebuilding the whole screen while dragging.
  final _sheetExtent = ValueNotifier<double?>(null);

  @override
  void dispose() {
    _sheetExtent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        // The fields sit at the top, so the keyboard never covers them;
        // resizing would recompute the sheet sizes and make it jump.
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bodyHeight = constraints.maxHeight;

            // Sheet sizes as fractions of the body (screen minus tab bar).
            final maxSize = ((bodyHeight - topInset) / bodyHeight).clamp(0.5, 1.0);
            final initialSize =
                ((bodyHeight - topInset - MapHeader.sheetTop) / bodyHeight).clamp(0.2, maxSize);
            final minSize = math.min(0.3, initialSize);

            return Stack(
              children: [
                Positioned.fill(
                  child: MapHeader(city: AppViewMockData.currentCity, topInset: topInset),
                ),
                _FollowingLocateButton(
                  extent: _sheetExtent,
                  initialSize: initialSize,
                  bodyHeight: bodyHeight,
                ),
                NotificationListener<DraggableScrollableNotification>(
                  onNotification: (n) {
                    _sheetExtent.value = n.extent;
                    return false;
                  },
                  child: RideBottomSheet(
                    initialSize: initialSize,
                    minSize: minSize,
                    maxSize: maxSize,
                    child: const RideSheetContent(),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: RideBottomNav(
          items: AppViewMockData.navItems,
          selectedIndex: _selectedTab,
          onSelected: (i) => setState(() => _selectedTab = i),
        ),
      ),
    );
  }
}

/// Keeps the locate button 15 (design px) above the sheet's top edge and
/// fades it out once the sheet is pulled above its resting position.
class _FollowingLocateButton extends StatelessWidget {
  const _FollowingLocateButton({
    required this.extent,
    required this.initialSize,
    required this.bodyHeight,
  });

  final ValueNotifier<double?> extent;
  final double initialSize;
  final double bodyHeight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double?>(
      valueListenable: extent,
      builder: (context, value, child) {
        final size = value ?? initialSize;
        final overshoot = ((size - initialSize) * bodyHeight / 60.h).clamp(0.0, 1.0);

        return Positioned(
          right: 19.w,
          bottom: size * bodyHeight + 15.h,
          child: IgnorePointer(
            ignoring: overshoot > 0.5,
            child: Opacity(opacity: 1 - overshoot, child: child),
          ),
        );
      },
      child: const LocateButton(),
    );
  }
}
