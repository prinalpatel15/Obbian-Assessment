import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/recent_place.dart';
import 'recent_place_tile.dart';

class RecentPlacesList extends StatelessWidget {
  const RecentPlacesList({super.key, required this.places});

  final List<RecentPlace> places;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < places.length; i++) ...[
          if (i > 0) SizedBox(height: 6.h),
          RecentPlaceTile(place: places[i]),
        ],
      ],
    );
  }
}
