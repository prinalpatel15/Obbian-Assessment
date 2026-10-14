import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obbian_assessment/core/constants/app_assets.dart';

/// Small white "my location" button that sits just above the sheet.
class LocateButton extends StatelessWidget {
  const LocateButton({super.key, this.onTap});

  final VoidCallback? onTap;

  static double get size => 26.r;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(7.r);
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black26,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap ?? () {},
        child: SizedBox(
          height: 26.h,
          width: 26.w,
          // child: Icon(Icons.near_me, size: 15.r, color: const Color(0xFF1F2A44)),
          child: Center(child: SvgPicture.asset(AppAssets.share)),
        ),
      ),
    );
  }
}
