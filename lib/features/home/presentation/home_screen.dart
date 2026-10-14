import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes.dart';
import 'widgets/view_option_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
          children: [
            Text(
              'Welcome',
              style: textTheme.headlineMedium?.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose how you want to explore.',
              style: textTheme.bodyLarge?.copyWith(fontSize: 16.sp, color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 32.h),
            ViewOptionCard(
              icon: Icons.language_rounded,
              title: 'Web View',
              description: 'Open the website inside the app.',
              onTap: () => Navigator.pushNamed(context, AppRoutes.webView),
            ),
            SizedBox(height: 16.h),
            ViewOptionCard(
              icon: Icons.phone_iphone_rounded,
              title: 'App View',
              description: 'Use the native app experience.',
              onTap: () => Navigator.pushNamed(context, AppRoutes.appView),
            ),
          ],
        ),
      ),
    );
  }
}
