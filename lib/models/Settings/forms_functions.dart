import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../../custom_text.dart';

CustomText customText(String text, double size) {
  return CustomText(
    text: text,
    size: 22,
    weight: FontWeight.bold,
    color: white,
  );
}

SizedBox space(double val) {
  return SizedBox(
    height: val,
  );
}
