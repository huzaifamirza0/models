import 'package:flutter/material.dart';

class ResponsiveSize {
  static const double mobileWidth = 375.0;
  static const double tabletWidth = 768.0;
  static const double desktopWidth = 1024.0;
  static const double largeDesktopWidth = 1920.0;

  static const double mobileScale = 1.0; // No scaling for mobile
  static const double tabletScale = 1.1; // Slight increase for tablets
  static const double desktopScale = 1.2; // Increase for desktops
  static const double largeDesktopScale = 1.3; // Increase for large desktops

  static double getSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    double scaleFactor;
    if (screenWidth <= mobileWidth) {
      scaleFactor = mobileScale;
    } else if (screenWidth <= tabletWidth) {
      scaleFactor = tabletScale;
    } else if (screenWidth <= desktopWidth) {
      scaleFactor = desktopScale;
    } else {
      scaleFactor = largeDesktopScale;
    }

    final adjustedSize = size * scaleFactor / pixelRatio;
    return adjustedSize.clamp(size * 0.8, size * 1.5); // Adjust clamp range
  }

  static double getWidth(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > desktopWidth) {
      return size.clamp(300, 600); // Constrain width on web
    }
    return size;
  }
}


double rs(BuildContext context, double value) {
  return ResponsiveSize.getSize(context, value);
}

double rw(BuildContext context, double value) {
  return ResponsiveSize.getWidth(context, value);
}