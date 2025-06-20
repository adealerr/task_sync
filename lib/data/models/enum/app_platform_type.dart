/// типы платформ
enum AppPlatformType {
  desktop,
  mobile,
  unknown;

  bool get isDesktop => this == desktop;
  bool get isMobile => this == mobile;
}
