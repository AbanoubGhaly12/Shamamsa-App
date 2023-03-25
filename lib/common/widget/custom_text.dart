import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign align;
  final bool isUnderline;
  final Function()? onClicked;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText(
      {Key? key,
      required this.text,
      required this.style,
      this.align = TextAlign.start,
      this.onClicked,
      this.maxLines,
      this.overflow,
      this.isUnderline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Text(
        text,
        overflow: overflow,
        softWrap: true,
        maxLines: maxLines,
        style: style.copyWith(
          decoration: isUnderline ? TextDecoration.underline : null,
        ),
        textAlign: align,
      ),
    );
  }
}
