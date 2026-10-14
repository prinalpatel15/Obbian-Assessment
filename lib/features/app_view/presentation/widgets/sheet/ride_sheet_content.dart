import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/app_view_mock_data.dart';
import '../common/section_title.dart';
import '../media/explore_places_row.dart';
import '../media/neighborhood_carousel.dart';
import '../recent/recent_places_list.dart';
import '../rides/rides_grid.dart';

/// Sections inside the bottom sheet (below the pinned handle).
class RideSheetContent extends StatelessWidget {
  const RideSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RecentPlacesList(places: AppViewMockData.recentPlaces),
        SizedBox(height: 17.h),
        SectionTitle('Rides', style: AppTextStyles.sectionTitle),
        SizedBox(height: 18.h),
        const RidesGrid(),
        SizedBox(height: 35.h),
        SectionTitle(
          'Explore Places with Ride app',
          style: AppTextStyles.sectionTitleAccent,
        ),
        SizedBox(height: 18.h),
        const ExplorePlacesRow(items: AppViewMockData.explorePlaces),
        SizedBox(height: 42.h),
        const SectionTitle('Your Neighborhood, Now on Ride App.'),
        SizedBox(height: 15.h),
        const NeighborhoodCarousel(items: AppViewMockData.neighborhood),
        SizedBox(height: 20.h),
      ],
    );
  }
}
