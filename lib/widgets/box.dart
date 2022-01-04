

import 'package:flutter/material.dart';
import 'package:vuitton_club/contants.dart';




Column itemBox( {required String s1,String? s2="", required String iconData}) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
    height: 90,
    width: 90,
    decoration: BoxDecoration(
      color: button_color,
      border: Border.all(
        color: Colors.black,
        width: 4,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Tab(
      icon:  Image.asset(
                  iconData,
                  height: 60,
                  width: 60,
                ),
    ),
  ),
      SizedBox(
        height: 5,
      ),
      Text(
        s1,
        style: myStyle(15, 'Bizmo2'),
      ),
      Text(
        s2!,
        style: myStyle(15, 'Bizmo2'),
      )
    ],
  );
  }