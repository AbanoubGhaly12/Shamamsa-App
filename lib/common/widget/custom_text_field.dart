import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/size_manager.dart';

class CustomTextField extends StatelessWidget {
  final bool obscure;
  final bool isReadOnly;
  final bool? done;
  final int lines;
  final int? maxLength;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextEditingController controller;
  final bool? validation;
  final String? validationText;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool? showCursor;
  final bool enableSuggestions;
  final Function(String text)? onChange;
  final Function()? onTap;
  final Function(String text)? onSubmitted;
  final Function()? onChangeCompleted;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? inputDecoration;

  const CustomTextField(
      {Key? key,
        required this.controller,
        this.hintText,
        this.errorText,
        this.textStyle,
        this.obscure = false,
        this.lines = 1,
        this.maxLength,
        this.suffix,
        this.textAlign = TextAlign.start,
        this.textInputAction,
        this.focusNode,
        this.done,
        this.keyboardType,
        this.validation,
        this.validationText,
        this.onChange,
        this.onTap,
        this.showCursor,
        this.isReadOnly = false,
        this.autoFocus = false,
        this.enableSuggestions = true,
        this.onChangeCompleted,
        this.inputFormatters,
        this.inputDecoration,
        this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: errorText == null ? EdgeInsets.zero : const EdgeInsets.only(bottom: SizeManager.s8),
      child: TextFormField(

        onFieldSubmitted: onSubmitted,
        enableSuggestions: enableSuggestions,
        showCursor: showCursor,
        autofocus: autoFocus,
        focusNode: focusNode,
        obscuringCharacter: "*",
        readOnly: isReadOnly,
        onTap: onTap,
        textInputAction: textInputAction,
        onChanged: onChange,
        onEditingComplete: onChangeCompleted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (validation == false && validation != null) {
            return validationText;
          } else if (value!.isEmpty) {
            return validationText;
          } else {
            return null;
          }
        },
        controller: controller,
        maxLines: lines,
        //   cursorColor: appBasicColor,
        textAlign: textAlign,
        maxLength: maxLength,
        // textDirection: TextDirection.L,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: textStyle,
        decoration: inputDecoration ??
            InputDecoration(
                fillColor: Colors.white,
                hintText: hintText,
                errorText: errorText,
                suffix: suffix,
                errorMaxLines: 2),
        inputFormatters: inputFormatters,
      ),
    );
  }
}
