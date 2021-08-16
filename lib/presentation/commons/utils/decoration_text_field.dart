import 'package:flutter/material.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';

class DecorationTextField {
  static vegaInputDecoration({String label, IconButton suffixIcon}) {
    return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: suffixIcon,
        labelStyle: textMediumColor(boldCondition: true, color: colorPrimary),
        hintStyle: textMediumColor(boldCondition: false, color: colorAccent),
        errorStyle: textSmallColor(boldCondition: false, color: colorError));
  }
}
