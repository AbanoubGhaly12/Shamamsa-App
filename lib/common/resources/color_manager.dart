import 'package:flutter/material.dart';

/// [ColorsManager] class
/// Contains all Application Colors
class ColorsManager {
  static Color background = brightGrey;
  static Color babyBlueEyes = HexColor.fromHex("#A0BFEE");
  static Color coolBlack = HexColor.fromHex("#012965");
  static Color ultramarineBlue = HexColor.fromHex("#2F65EB");
  static Color metallicOrange = HexColor.fromHex("#DD6014");
  static Color brilliantLavender = HexColor.fromHex("#FFA0F9");
  static Color caribbeanGreen = HexColor.fromHex("#00D494");
  static Color ripeMango = HexColor.fromHex("#FFC425");
  static Color darkCharcoal = HexColor.fromHex("#2D2E30");
  static Color black = HexColor.fromHex("#000000");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color brightGrey = HexColor.fromHex("#EBEBEB");
  static Color argent = HexColor.fromHex("#BFBFBF");
  static Color quickSilver = HexColor.fromHex("#A3A3A3");
  static Color alto = HexColor.fromHex("#DEDEDE");
  static Color disabledGrey = HexColor.fromHex("#7D7D7D");
  static Color error = HexColor.fromHex("#FE4C4C");
  static Color borderColor = HexColor.fromHex("#79FFC7");
}


/// [HexColor] extension
/// Convert form  {hex color string} to Color
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}