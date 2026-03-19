import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
class Responsive {
  /// Breakpoints for different device types
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  /// Get device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Get responsive value based on device type
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return responsiveValue<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tablet: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      desktop: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
    );
  }

  /// Get responsive font size
  static double responsiveFontSize(
    BuildContext context,
    double mobileSize, {
    double? tabletSize,
    double? desktopSize,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobileSize,
      tablet: tabletSize ?? mobileSize * 1.2,
      desktop: desktopSize ?? mobileSize * 1.5,
    );
  }

  /// Get responsive grid cross axis count
  static int responsiveGridCount(BuildContext context) {
    return responsiveValue<int>(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
  }

  /// Get responsive spacing (height/width)
  static double responsiveSpacing(
    BuildContext context,
    double mobileSpacing, {
    double? tabletSpacing,
    double? desktopSpacing,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing * 1.5,
      desktop: desktopSpacing ?? mobileSpacing * 2.0,
    );
  }

  /// Get responsive image size
  static double responsiveImageSize(
    BuildContext context,
    double mobileSize, {
    double? tabletSize,
    double? desktopSize,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobileSize,
      tablet: tabletSize ?? mobileSize * 1.3,
      desktop: desktopSize ?? mobileSize * 1.6,
    );
  }

  /// Get responsive margin
  static EdgeInsets responsiveMargin(BuildContext context) {
    return responsiveValue<EdgeInsets>(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  /// Get max width for content containers (prevents content from being too wide on desktop)
  static double? maxContentWidth(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return null; // No max width on mobile
      case DeviceType.tablet:
        return 800;
      case DeviceType.desktop:
        return 1200;
    }
  }

  /// Get responsive border radius
  static double responsiveBorderRadius(
    BuildContext context,
    double mobileRadius, {
    double? tabletRadius,
    double? desktopRadius,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobileRadius,
      tablet: tabletRadius ?? mobileRadius * 1.2,
      desktop: desktopRadius ?? mobileRadius * 1.5,
    );
  }

  /// Get responsive icon size
  static double responsiveIconSize(
    BuildContext context,
    double mobileSize, {
    double? tabletSize,
    double? desktopSize,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobileSize,
      tablet: tabletSize ?? mobileSize * 1.2,
      desktop: desktopSize ?? mobileSize * 1.4,
    );
  }

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get responsive percentage of screen height
  static double heightPercent(BuildContext context, double percent) {
    return screenHeight(context) * (percent / 100);
  }

  /// Get responsive percentage of screen width
  static double widthPercent(BuildContext context, double percent) {
    return screenWidth(context) * (percent / 100);
  }
}

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

