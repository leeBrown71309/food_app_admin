import 'package:flutter/material.dart';
import 'help/app_colors.dart';

Padding padding(String ht, IconData icon1,
    TextEditingController? controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(color: SideMenuColor1,
      borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          style: TextStyle(color: white),
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
              hoverColor: Colors.white54,

              border: InputBorder.none,
              hintText: ht,
              hintStyle: TextStyle(color: Colors.white54),
              icon: Icon(
                icon1,
                color: white,
              )),
        ),
      ),
    ),
  );
}
