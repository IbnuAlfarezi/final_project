import 'package:flutter/material.dart';

class AppImageStyle {

  static Widget asset({
    required String path,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color, 
      fit: fit,
    );
  }


  static Widget network({
    required String url,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.cover,
    Widget? errorWidget,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      color: color,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const Icon(Icons.broken_image, size: 50),
    );
  }
}
