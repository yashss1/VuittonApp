import 'package:flutter/material.dart';

import '../contants.dart';

TextField textfield(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return TextField(
    cursorColor: Colors.black,
    onChanged: (val) {},
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(20),
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
    keyboardType: TextInputType.text,
    style: myStyle(size, "Bizmo", color: Colors.black),
    controller: controller,
  );
}

TextField textfieldSmall(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return TextField(
    cursorColor: Colors.black,
    onChanged: (val) {},
    maxLength: 3,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(20),
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
    keyboardType: TextInputType.text,
    style: myStyle(size, "Bizmo", color: Colors.black),
    controller: controller,
  );
}
