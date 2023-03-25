import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/size_manager.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular style

TextStyle regularStyle(
    {double fontSize = SizeManager.s12,
    required Color color,
    String? fontFamily}) {
  return _getTextStyle(
    fontSize,
    fontFamily ?? FontManager.cairo,
    color,
    FontWeightManager.regular,
  );
}

// Light style

TextStyle lightStyle(
    {double fontSize = SizeManager.s12,
    required Color color,
    String? fontFamily}) {
  return _getTextStyle(
    fontSize,
    fontFamily ?? FontManager.cairo,
    color,
    FontWeightManager.light,
  );
}

// medium style

TextStyle mediumStyle(
    {double fontSize = SizeManager.s12,
    required Color color,
    String? fontFamily}) {
  return _getTextStyle(
    fontSize,
    fontFamily ?? FontManager.cairo,
    color,
    FontWeightManager.medium,
  );
}
// semibold style

TextStyle semiBoldStyle(
    {double fontSize = SizeManager.s12,
    required Color color,
    String? fontFamily}) {
  return _getTextStyle(
    fontSize,
    fontFamily ?? FontManager.cairo,
    color,
    FontWeightManager.semiBold,
  );
}
// bold style

TextStyle boldStyle(
    {double fontSize = SizeManager.s12,
    required Color color,
    String? fontFamily}) {
  return _getTextStyle(
    fontSize,
    fontFamily ?? FontManager.cairo,
    color,
    FontWeightManager.bold,
  );
}

// enum StyleManager {
//   xSmallRegular,
//   smallRegular,
//   mediumRegular,
//   mediumBold,
//   largeRegular,
//   xLargeRegular,
//   smallBold,
//   largeBold,
//   xLargeBold,
// }

enum StyleManager {
  cairoSmallRegular,
  cairoSmallBold,
  cairoBodyRegular,
  cairoBodyBold,
  cairoMediumRegular,
  cairoMediumBold,
}

extension ThemeExtension on StyleManager {
  TextStyle getStyle({required BuildContext context}) {
    switch (this) {
      case StyleManager.cairoSmallRegular:
        return Theme.of(context).textTheme.subtitle1!;
      case StyleManager.cairoSmallBold:
        return Theme.of(context).textTheme.subtitle2!;
      case StyleManager.cairoMediumRegular:
        return Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeightManager.regular);
      case StyleManager.cairoMediumBold:
        // TODO: Handle this case.
        return Theme.of(context).textTheme.headline6!;

      case StyleManager.cairoBodyBold:
        return Theme.of(context).textTheme.bodyText1!;

      default:
        return Theme.of(context).textTheme.bodyText1!;
    }
  }
}
