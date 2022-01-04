import 'package:flutter/material.dart';

ElevatedButton button (
  {required void Function()? onPressed, required Widget? child,}
){
  return ElevatedButton(
    child: child,
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontFamily: "Bizmo2",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 26,
                  ),
                  fixedSize: Size(370, 67),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),

  );
}