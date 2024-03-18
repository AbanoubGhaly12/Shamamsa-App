import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/widget/custom_text.dart';

import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/text_manager.dart';

class CustomCheckBox extends StatelessWidget {
  bool value;
  Function(bool? val) onChanged;

  final String title;

  CustomCheckBox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            fillColor: MaterialStatePropertyAll(ColorsManager.white),
            checkColor: ColorsManager.darkCharcoal,
            activeColor: ColorsManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: ColorsManager.darkCharcoal, width: 2),
            ),
            value: value,
            onChanged: onChanged,
          ),
          CustomText(
            text: title,
            style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
