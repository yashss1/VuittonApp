import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/Menu/Membership_none.dart';
import 'package:vuitton_club/Menu/history.dart';
import 'package:vuitton_club/Menu/Membership.dart';

import 'package:vuitton_club/Menu/alerts.dart';
import 'package:vuitton_club/Menu/membership_social.dart';
import 'package:vuitton_club/Menu/profile.dart';
import 'package:vuitton_club/Menu/settings.dart';
import 'package:vuitton_club/Onboarding/phone.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/box.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut(context) async {
    await _auth.signOut();
    print('Signout');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => PhonePage()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    // print("${UserDetails.name} = Admin ?? -> ${UserDetails.isAdmin}");
  }

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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.close,
                      size: 50,
                    ),
                    alignment: Alignment.topRight,
                  ),
                ),
                Text("VUITTON \nCLUB", style: myStyle(55, "Bizmo")),
                Container(
                  child: Text(
                      "Hey, ${UserDetails.name}. Welcome to the club’s app 👋.",
                      style: myStyle(
                        20,
                        "Bizmo2",
                      )),
                ),
                SizedBox(height: 40),
                Container(
                  child: Text("How can we help you out?",
                      style: myStyle(
                        20,
                        "Bizmo",
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile())),
                        child: itemBox(
                          s1: "Profile",
                          iconData: "assets/images/card.png",
                        )),
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => History())),
                      child: itemBox(
                        s1: "History",
                        iconData: "assets/images/history.png",
                      ),
                    ),
                    SizedBox(
                      child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Alerts())),
                        child: itemBox(
                          s1: "Alerts",
                          iconData: "assets/images/alerts.png",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails.license_data == null
                              ? MembershipNone()
                              : UserDetails.license_data!['plan']['name']
                                          .contains('Social') ==
                                      true
                                  ? MembershipSocial()
                                  : Membership(),
                        ),
                      ),
                      child: itemBox(
                        s1: "Membershp",
                        iconData: "assets/images/membership.png",
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings())),
                      child: itemBox(
                        s1: "Settings",
                        iconData: "assets/images/settings.png",
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        signOut(context);
                      },
                      child: Column(
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
                              icon: Icon(
                                Icons.logout_outlined,
                                size: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Log Out",
                            style: myStyle(15, 'Bizmo2'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
