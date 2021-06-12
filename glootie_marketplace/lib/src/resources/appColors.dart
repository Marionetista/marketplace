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
  static const Color pinky = Color(0xffd05dad);
  static const Color whitePinky = Color(0xfffcf2f9);
  static const Color acai = Color(0xff5b516e);
}
