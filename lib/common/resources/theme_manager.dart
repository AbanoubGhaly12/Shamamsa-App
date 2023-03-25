
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shamamsa_app/common/resources/size_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Main App Color
    primaryColor: ColorsManager.metallicOrange,
    disabledColor: ColorsManager.disabledGrey,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorsManager.brightGrey,
    ),
    //ripple color
    //splashColor: ColorManager.primaryOpacity70,
    //Card View Theme
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.brightGrey,
      elevation: SizeManager.s4,
    ),
    scaffoldBackgroundColor: ColorsManager.background,
    //App Bar Theme

    // appBarTheme: AppBarTheme(
    //   color: ColorsManager.wireFrameMainColor,
    //   elevation: SizeManager.s4,
    //   shadowColor: ColorsManager.wireFrameMainColor,
    //   titleTextStyle: regularStyle(
    //     color: ColorsManager.primary,
    //     fontSize: SizeManager.s16.sp,
    //   ),
    // ),

    //Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.disabledGrey,
      buttonColor: ColorsManager.caribbeanGreen,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      // textStyle: regularStyle(
      //   color: ColorManager.black,
      //   fontSize: SizeManager.s16,
      //   fontFamily: FontManager.textFontFamily
      // ),
      shadowColor: Colors.transparent,
      elevation: SizeManager.s0,
      primary: Colors.transparent,
      shape: const StadiumBorder(),
    )),
    // Text theme
    textTheme: TextTheme(
      /// Titles [TextStyle]
      headline1: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s35.sp,
        fontFamily: FontManager.cairo,
      ),

      /// Numbers [TextStyle]
      headline2: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s25.sp,
        fontFamily: FontManager.cairo,
      ),
      headline3: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s20.sp,
        fontFamily: FontManager.cairo,
      ),
      headline4: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s35.sp,
        fontFamily: FontManager.cairo,
      ),
      headline5: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s25.sp,
        fontFamily: FontManager.cairo,
      ),
      headline6: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s20.sp,
        fontFamily: FontManager.cairo,
      ),

      /// Text subTitles [TextStyle]

      subtitle1: regularStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s12.sp,
        fontFamily: FontManager.cairo,
      ),

      /// Numbers subTitles [TextStyle]
      subtitle2: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s12.sp,
        fontFamily: FontManager.cairo,
      ),

      caption: regularStyle(
        color: ColorsManager.brightGrey,
      ),

      /// Body [TextStyle]

      bodyText1: boldStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s14.sp,
        fontFamily: FontManager.cairo,
      ),
      bodyText2: regularStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s15.sp,
        fontFamily: FontManager.cairo,
      ),
    ),

    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.only(
        left: SizeManager.s20,
        right: SizeManager.s20,
        top: SizeManager.s10,
        bottom: SizeManager.s10,
      ),
      // hint style
      hintStyle: regularStyle(
        color: ColorsManager.quickSilver,
        fontSize: SizeManager.s16.sp,
      ),

      // label style
      labelStyle: mediumStyle(
        color: ColorsManager.white,
        fontSize: SizeManager.s16.sp,
      ),
      // error style
      errorStyle: regularStyle(
        color: ColorsManager.quickSilver,
        fontSize: SizeManager.s12.sp,
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: SizeManager.s1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            SizeManager.s5,
          ),
        ),
      ),
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.black,
          width: SizeManager.s0_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            SizeManager.s5,
          ),
        ),
      ),

      // focused border
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: SizeManager.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            SizeManager.s5,
          ),
        ),
      ),

      // error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.error,
          width: SizeManager.s0_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            SizeManager.s5,
          ),
        ),
      ),
      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.error,
          width: SizeManager.s0_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            SizeManager.s5,
          ),
        ),
      ),
    ),

    cupertinoOverrideTheme: CupertinoThemeData(
        barBackgroundColor: ColorsManager.caribbeanGreen,
        textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: regularStyle(
              color: ColorsManager.black,
              fontSize: SizeManager.s20.sp,
              fontFamily: FontManager.cairo,
            ),
        )
    ),
  );

  //Input Decoration Theme
}
