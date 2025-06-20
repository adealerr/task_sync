import 'package:flutter/foundation.dart';
import 'package:task_sync/data/models/enum/app_platform_type.dart';

class PlatformHelper {
  PlatformHelper._();

  static AppPlatformType get runningPlatform {
    final platform = defaultTargetPlatform;
    if (platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows) {
      return AppPlatformType.desktop;
    } else if (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS) {
      return AppPlatformType.mobile;
    } else {
      return AppPlatformType.unknown;
    }
  }
}
