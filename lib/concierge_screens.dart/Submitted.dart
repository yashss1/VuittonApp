import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class Submitted extends StatefulWidget {
  const Submitted({Key? key}) : super(key: key);

  @override
  _SubmittedState createState() => _SubmittedState();
}

class _SubmittedState extends State<Submitted> {
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
                Container(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 50,
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                SizedBox(height: 120),
                Text("THANK", style: myStyle(55, "Bizmo")),
                Text("YOU", style: myStyle(55, "Bizmo")),
                SizedBox(height: 20),
                Container(
                  child: Text("Your concierge request has been",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
                Container(
                  child: Text("submitted.",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
                SizedBox(height: 30),
                Container(
                  child: Text("We will be reaching out directly",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
                Container(
                  child: Text("via Email / DM when we have",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
                Container(
                  child: Text("an update ready for you.",
                      style: myStyle(
                        15,
                        "Bizmo2",
                      )),
                ),
                SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  child: button(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home())),
                    child: Text("HOME"),

                   
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}
