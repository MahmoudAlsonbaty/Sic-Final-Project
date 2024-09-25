import 'dart:ui';

Color getColorFromHex(String hexColor) {
  late final String hexCode;
  if (hexColor[0] == "#") {
    hexCode = hexColor.replaceAll('#', '');
  } else {
    hexCode = hexColor;
  }
  return Color(int.parse('FF$hexCode', radix: 16));
}
