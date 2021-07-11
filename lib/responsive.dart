import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

enum Size { desktop, tablet, mobile }

const double desktopMinSize = 1100;
const double tabletMinSize = 850;
const double mobileMinSize = 300;

class DeviceSize {
  static bool isMobile(BuildContext context) => of(context) == Size.mobile;
  static bool isTablet(BuildContext context) => of(context) == Size.tablet;
  static bool isDesktop(BuildContext context) => of(context) == Size.desktop;

  static Size of(BuildContext context) {
    // Use .shortestSide to detect device type regardless of orientation
    final double deviceSize = MediaQuery.of(context).size.shortestSide;
    if (deviceSize > desktopMinSize) return Size.desktop;
    if (deviceSize > tabletMinSize) return Size.tablet;
    return Size.mobile;
  }
}

// ignore: avoid_classes_with_only_static_members
class DeviceType {
  // Syntax sugar, proxy the UniversalPlatform methods so our views can reference a single API
  static bool isIOS = UniversalPlatform.isIOS;
  static bool isAndroid = UniversalPlatform.isAndroid;
  static bool isMacOS = UniversalPlatform.isMacOS;
  static bool isLinux = UniversalPlatform.isLinux;
  static bool isWindows = UniversalPlatform.isWindows;

  // Higher level device class abstractions (more syntax sugar for the views)
  static bool isWeb = UniversalPlatform.isWeb;
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
  static bool get isMobileOrWeb => isMobile || isWeb;
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    switch (DeviceSize.of(context)) {
      case Size.desktop:
        return desktop;
      case Size.tablet:
        return tablet;
      case Size.mobile:
        return mobile;
    }
  }
}
