import 'package:flutter/material.dart';
import 'package:task_sync/data/models/enum/app_platform_type.dart';
import 'package:task_sync/utils/platform_helper.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    required this.wide,
    required this.narrow,
    super.key,
  });

  final Widget wide;
  final Widget narrow;

  @override
  Widget build(BuildContext context) {
    final isMobile = PlatformHelper.runningPlatform.isMobile;

    return isMobile ? narrow : wide;
  }
}
