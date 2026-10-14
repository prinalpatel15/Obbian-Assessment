import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_back_button.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.url = AppConstants.webViewUrl});

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => setState(() => _progress = progress),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  /// Navigate back inside the web page first, leave the screen only when
  /// there is no web history left.
  Future<void> _handlePop(bool didPop, Object? result) async {
    if (didPop) return;
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    } else if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePop,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 56.w,
          leading: Center(child: AppBackButton(onPressed: () => Navigator.of(context).pop())),
          title: const Text('Web View'),
          actions: [
            IconButton(
              tooltip: 'Reload',
              icon: Icon(Icons.refresh_rounded, size: 24.r),
              onPressed: _controller.reload,
            ),
          ],
          bottom: _progress < 100
              ? PreferredSize(
                  preferredSize: Size.fromHeight(2.h),
                  child: LinearProgressIndicator(value: _progress / 100, minHeight: 2.h),
                )
              : null,
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
