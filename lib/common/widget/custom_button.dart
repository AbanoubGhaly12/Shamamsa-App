
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/size_manager.dart';
import '../resources/style_manager.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text, icon;
  final double? iconWidth,
      iconHeight,
      width,
      height,
      borderRadius,
      spaceBetweenIconAndText;
  final Function()? onPressed;
  final bool? hasBorder;
  final Color? textColor, disabledColor, buttonColor, borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;
  final bool isDisabled, hasBorderRadius;
  final BoxShape shape;

  const CustomButton(
      {Key? key,
      this.text,
      this.iconWidth,
      this.iconHeight,
      this.icon,
      this.onPressed,
      this.margin,
      this.width,
      this.height,
      this.borderRadius,
      this.spaceBetweenIconAndText,
      this.textStyle,
      this.buttonColor,
      this.disabledColor,
      this.textColor = Colors.white,
      this.isDisabled = false,
      this.hasBorder = true,
      this.hasBorderRadius = true,
      this.borderColor,
      this.shape = BoxShape.rectangle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasBorderRadius = shape == BoxShape.circle ? false : this.hasBorderRadius;
    final borderRadius = BorderRadius.circular(
      (this.borderRadius ?? SizeManager.s32).sm,
    );
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          border: hasBorder == false || isDisabled || onPressed == null
              ? null
              : Border.all(
                  style: BorderStyle.solid,
                  color: borderColor ?? Colors.transparent),
          shape: shape,
          color: !isDisabled
              ? buttonColor ?? ColorsManager.caribbeanGreen
              : disabledColor,
          borderRadius: !hasBorderRadius
              ? null
              : borderRadius,
                ),
      width: (width)?.w,
      height: (height ?? SizeManager.s45).h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: shape == BoxShape.circle
                  ? MaterialStateProperty.all(const CircleBorder())
                  : MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: borderRadius)),
            ),
        child: icon == null? text == null?Container():FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            text: text!,
            style: (textStyle ??
                StyleManager.cairoMediumRegular
                    .getStyle(context: context))
                .copyWith(
              color: textColor,
            ),
            align: TextAlign.center,
          ),
        ):Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (icon != null && spaceBetweenIconAndText != null)
              SizedBox(
                width: spaceBetweenIconAndText?.w,
              ),
            if (text != null)
              CustomText(
                text: text!,
                style: (textStyle ??
                        StyleManager.cairoMediumRegular
                            .getStyle(context: context))
                    .copyWith(
                  color: textColor,
                ),
                align: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
