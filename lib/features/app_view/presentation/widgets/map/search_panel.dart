import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../common/glass_container.dart';

/// Frosted card with the "Pick Up" and "Where to?" text fields.
class SearchPanel extends StatefulWidget {
  const SearchPanel({super.key, this.onPickUpChanged, this.onDestinationChanged, this.onSubmitted});

  final ValueChanged<String>? onPickUpChanged;
  final ValueChanged<String>? onDestinationChanged;

  /// Called from the "Where to?" keyboard action with (pickUp, destination).
  final void Function(String pickUp, String destination)? onSubmitted;

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final _pickUpController = TextEditingController();
  final _destinationController = TextEditingController();
  final _destinationFocus = FocusNode();

  @override
  void dispose() {
    _pickUpController.dispose();
    _destinationController.dispose();
    _destinationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 13.h, 16.w, 13.h),
      child: Column(
        children: [
          _SearchField(
            hint: 'Pick Up (Default on map)',
            controller: _pickUpController,
            textInputAction: TextInputAction.next,
            onChanged: widget.onPickUpChanged,
            onSubmitted: (_) => _destinationFocus.requestFocus(),
          ),
          SizedBox(height: 13.h),
          _SearchField(
            hint: 'Where to?',
            controller: _destinationController,
            focusNode: _destinationFocus,
            textInputAction: TextInputAction.search,
            onChanged: widget.onDestinationChanged,
            onSubmitted: (value) => widget.onSubmitted?.call(_pickUpController.text, value),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.hint,
    required this.controller,
    required this.textInputAction,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 40.r),
      decoration: const ShapeDecoration(color: Colors.white, shape: StadiumBorder()),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          SvgPicture.asset(AppAssets.pickDrop, height: 16.r),
          SizedBox(width: 18.w),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              style: AppTextStyles.label,
              cursorColor: AppColors.primary,
              cursorHeight: 14.sp,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.hint,
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 16.w, top: 10.h, bottom: 10.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
