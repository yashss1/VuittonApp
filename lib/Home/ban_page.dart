import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/contants.dart';

class BanPage extends StatefulWidget {
  const BanPage({Key? key}) : super(key: key);

  @override
  _BanPageState createState() => _BanPageState();
}

class _BanPageState extends State<BanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: top_margin, left: 22, right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 120),
                Text("You've Been", style: myStyle(55, "Bizmo")),
                Text("Blacklisted", style: myStyle(55, "Bizmo")),
                SizedBox(height: 20),
                Container(
                  child: Text("Please Contact Vuitton Club",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
