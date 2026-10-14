import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.style});

  final String text;

  /// Defaults to [AppTextStyles.sectionTitleSmall].
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(text, style: style ?? AppTextStyles.sectionTitleSmall),
    );
  }
}
