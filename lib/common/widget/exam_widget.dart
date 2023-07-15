import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/size_manager.dart';
import '../resources/style_manager.dart';
import '../resources/text_manager.dart';
import 'custom_button.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class ExamWidget extends StatelessWidget {
  final ExamUiModel examUiModel;
  final Function(String val) onChangeCompleted;

  const ExamWidget({Key? key, required this.examUiModel, required this.onChangeCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorsManager.darkCharcoal, borderRadius: BorderRadius.circular(SizeManager.s15)),
      margin: const EdgeInsets.all(SizeManager.s15),
      padding: const EdgeInsets.all(SizeManager.s15),
      child: Column(
        children: [
          CustomText(
            maxLines: 1,
            text: examUiModel.title,
            style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                  color: ColorsManager.white,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(SizeManager.s20),
            child: CustomTextField(
              validation: examUiModel.controller.text.isNotEmpty && int.parse(examUiModel.controller.text) <= examUiModel.validationScore,
              validationText: "برجاء ادخال الدرجة اصغر من ${examUiModel.validationScore}",
              onChange: onChangeCompleted,
              keyboardType: TextInputType.number,
              controller: examUiModel.controller,
              hintText: TextManager.score.tr(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: SizeManager.s10),
            child: CustomText(
              text: "برجاء ادخال الدرجة من ${examUiModel.validationScore}",
              style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                    color: ColorsManager.white,
                  ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class ExamUiModel {
  final TextEditingController controller;
  final String title;
  String score;
  final int validationScore;

  ExamUiModel(this.controller, this.title, this.score, this.validationScore);
}
