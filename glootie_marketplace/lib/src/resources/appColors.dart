import 'dart:ui';

class AppColors extends Color {
  AppColors(int color) : super(color);

  factory AppColors.hexColor(String hexColor) {
    var hex = hexColor.toUpperCase().replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return AppColors(int.parse(hex, radix: 16));
  }

  // Pink Color Shade - Body
  static const Color brokenAmethyst = Color(0xffcf62af);
  static const Color pinky = Color(0xfff1b4e2);
  static const Color violet = Color(0xff842672);
  static const Color whitePink = Color(0xfffef4fe);

  // Blue Color Shade - Eyes
  static const Color darkBlue = Color(0xff1d3f67);
  static const Color mediumBlue = Color(0xff466d89);
  static const Color cyan = Color(0xff87d7f4);
}
