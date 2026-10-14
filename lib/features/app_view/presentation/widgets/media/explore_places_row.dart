import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/media_card_item.dart';
import 'media_card.dart';

class ExplorePlacesRow extends StatelessWidget {
  const ExplorePlacesRow({super.key, required this.items});

  final List<MediaCardItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 126.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) SizedBox(width: 16.w),
              Expanded(child: MediaCard(item: items[i])),
            ],
          ],
        ),
      ),
    );
  }
}
