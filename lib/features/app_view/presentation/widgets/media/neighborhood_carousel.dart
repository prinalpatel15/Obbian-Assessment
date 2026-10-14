import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/media_card_item.dart';
import 'media_card.dart';
import 'play_button.dart';

/// Horizontally scrolling video cards with a shared [PlayButton].
class NeighborhoodCarousel extends StatelessWidget {
  const NeighborhoodCarousel({super.key, required this.items});

  final List<MediaCardItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (_, i) => SizedBox(
          width: 200.w,
          child: MediaCard(item: items[i], borderRadius: 16.r, photoHeight: 166.w),
        ),
      ),
    );
  }
}
