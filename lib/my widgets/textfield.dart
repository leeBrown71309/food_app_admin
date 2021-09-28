import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../constants.dart';

Padding padding(String ht, IconData icon1, IconData icon2,
    TextEditingController? controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(color: blueFont2),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hoverColor: Colors.white54,
              suffixIcon: Icon(
                icon1,
                color: white,
              ),
              border: InputBorder.none,
              hintText: ht,
              hintStyle: TextStyle(color: Colors.white54),
              icon: Icon(
                icon2,
                color: white,
              )),
        ),
      ),
    ),
  );
}
