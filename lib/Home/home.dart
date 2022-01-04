import 'package:flutter/material.dart';
import 'package:vuitton_club/Admin_Panel/Rolodex_admin.dart';
import 'package:vuitton_club/Admin_Panel/rolodex_admin_main.dart';
import 'package:vuitton_club/Home/home_locked.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/Menu/settings.dart';
import 'package:vuitton_club/Networking/Event_calender.dart';
import 'package:vuitton_club/Networking/repost_request.dart';
import 'package:vuitton_club/Networking/rolodex.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/concierge_screens.dart/Lux_good_request.dart';
import 'package:vuitton_club/concierge_screens.dart/car_request.dart';
import 'package:vuitton_club/concierge_screens.dart/charter_request.dart';
import 'package:vuitton_club/contants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/globals.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/widgets/box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? HomeAdmin()
        : Scaffold(
            backgroundColor: screen_color,
            body: Container(
              margin: EdgeInsets.only(top: top_margin, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu())),
                            child: Icon(
                              Icons.sort,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Center(
                            child: Text(
                              "VUITTON CLUB",
                              style: myStyle(25, 'Bizmo'),
                            ),
                          ),
                        ],
                      ),
                      UserDetails.isAdmin == true
                          ? Center(
                              child: Switch(
                                thumbColor: MaterialStateProperty.all(
                                    Color(0xFFEDBA4F)),
                                inactiveThumbColor: Color(0xFFEDBA4F),
                                hoverColor: Color(0xFFEDBA4F),
                                focusColor: Color(0xFFEDBA4F),
                                overlayColor: MaterialStateProperty.all(
                                    Color(0xFFEDBA4F)),
                                activeTrackColor: Color(0xFFEDBA4F),
                                activeColor: Color(0xFFEDBA4F),
                                value: isAdmin,
                                onChanged: (value) {
                                  setState(() {
                                    isAdmin = value;
                                  });
                                },
                              ),
                            )
                          : Center(),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
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
                              style: myStyle(26, 'Bizmo'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${UserDetails.name}",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Bizmo',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              "${UserDetails.location}",
                              style: myStyle(15, 'Bizmo2'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Image.asset(
                              'assets/images/Social_Yearly 1.png',
                              height: 80,
                              width: 180,
                            ),
                            Text(
                              "Social Member",
                              style: myStyle(15, 'Bizmo2'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Concierge Services",
                    style: myStyle(25, 'Bizmo'),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CharterRequest())),
                            child: itemBox(
                              s1: "Plane",
                              s2: "Charter",
                              iconData: "assets/images/jet.png",
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LuxGoodRequest())),
                            child: itemBox(
                              s1: "Luxury",
                              s2: "Goods",
                              iconData: "assets/images/lux.png",
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarRequest())),
                            child: itemBox(
                              s1: "Car",
                              s2: "Rental",
                              iconData: "assets/images/car.png",
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  Text(
                    "Networking",
                    style: myStyle(25, 'Bizmo'),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Rolodex())),
                            child: itemBox(
                              s1: "Club",
                              s2: "Rolodex",
                              iconData: "assets/images/card.png",
                            )),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RepostRequest())),
                          child: itemBox(
                            s1: "Repost",
                            s2: "Request",
                            iconData: "assets/images/insta.png",
                          ),
                        ),
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventCalender2())),
                            child: itemBox(
                              s1: "Event",
                              s2: "Calendar",
                              iconData: "assets/images/cal.png",
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
