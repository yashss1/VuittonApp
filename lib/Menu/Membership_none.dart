import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class MembershipNone extends StatefulWidget {
  const MembershipNone({Key? key}) : super(key: key);

  @override
  _MembershipNoneState createState() => _MembershipNoneState();
}

class _MembershipNoneState extends State<MembershipNone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: SingleChildScrollView(
          child: Container(
            // color: screen_color,
            margin: EdgeInsets.only(top: top_margin, left: 22, right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text("MEMBER-SHIP", style: myStyle(55, "Bizmo")),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 10),
                    child: Column(
                      children: [
                        Text(
                          "MEMBER PROFILE",
                          style: myStyle(26, 'Bizmo', color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${UserDetails.name}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Bizmo',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Text(
                          "${UserDetails.location}",
                          style: myStyle(15, 'Bizmo2', color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => License_Key())),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                "NO ACCESS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Bizmo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => License_Key()));
                    },
                    child: Text("LINK LICENSE KEY"),

                    // ignore: prefer_const_constructors
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 5.0,
                        color: Colors.black,
                      ),
                      primary: button_color,
                      onPrimary: Colors.black,
                      textStyle: TextStyle(
                        fontFamily: "Bizmo2",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                      fixedSize: Size(320, 67),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  child:button(
                    onPressed: () => {},
                    //  Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Home())),
                    child: Text("GO TO WEBSITE"),

                   
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
