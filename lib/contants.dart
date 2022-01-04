// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

TextStyle myStyle(double size, String fontFamily,
    {Color? color, FontWeight fw = FontWeight.w700, List<Shadow>? l}) {
  return TextStyle(
    fontSize: size,
    fontWeight: fw,
    color: color != "" ? color : text_color,
    fontFamily: fontFamily,
    shadows: l,
  );
}



TextField textfieldNumber(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return TextField(
    cursorColor: Colors.black,
    decoration: InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.black, width: 5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.black, width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.black, width: 5.0),
      ),
      hintText: hint_text,
      hintStyle: myStyle(size, "Bizmo", color: Colors.grey),
    ),
    keyboardType: TextInputType.number,
    style: myStyle(size, "Bizmo", color: Colors.black),
    controller: controller,
  );
}

Color screen_color = Color(0xFFF3EFD8);
Color text_color = Colors.black;
Color button_color = Color(0xFFEDBA4F);
double top_margin = 45.0;
