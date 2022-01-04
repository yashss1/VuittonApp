import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/Admin_Panel/event_calender.dart';
import 'package:vuitton_club/Admin_Panel/flights.dart';
import 'package:vuitton_club/Admin_Panel/Goods.dart';
import 'package:vuitton_club/Admin_Panel/repost.dart';
import 'package:vuitton_club/Admin_Panel/cars.dart';
import 'package:vuitton_club/Admin_Panel/rolodex_admin_main.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/contants.dart';

import 'package:vuitton_club/globals.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/widgets/box.dart';


class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return !isAdmin ? Home() : Scaffold(
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
                      context, MaterialPageRoute(builder: (context) => Menu())),
                  child: Icon(
                    Icons.sort,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "VUITTON CLUB",
                  style: myStyle(25, 'Bizmo'),
                ),
              ],
            ),
            Center(
              child: Switch(
                thumbColor: MaterialStateProperty.all(Color(0xFFEDBA4F)),
                inactiveThumbColor: Color(0xFFEDBA4F),
                hoverColor: Color(0xFFEDBA4F),
                focusColor: Color(0xFFEDBA4F),
                overlayColor: MaterialStateProperty.all(Color(0xFFEDBA4F)),
                activeTrackColor : Color(0xFFEDBA4F),
                activeColor: Color(0xFFEDBA4F),

                value: isAdmin,
                onChanged: (value) {
                  setState(() {
                    isAdmin = value;

                  });
                },


              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: (){},
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
                    "THEVUITTONCLUB",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bizmo',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    "Worldwide",
                    style: myStyle(15, 'Bizmo2'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("ADMIN"),

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
                        fixedSize: Size(215.0, 67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Member",
                    style: myStyle(15, 'Bizmo2'),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
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
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Flights())),
                child: itemBox(s1: "Plane", s2: "Charter",iconData:"assets/images/jet.png",)),
              InkWell(
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Goods())),
                child: itemBox(s1: "Luxury", s2: "Goods",iconData:"assets/images/lux.png",)),
              InkWell(
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Cars())), 
                child: itemBox(s1: "Car", s2: "Rental",iconData:"assets/images/car.png",)),
              
      
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
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>RolodexAdminMain())) ,
                child: itemBox(s1: "Club", s2: "Rolodex", iconData:"assets/images/card.png")),
              InkWell(
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Reposts())) ,
                child: itemBox(s1: "Repost", s2: "Request",iconData:"assets/images/insta.png",)),
              InkWell(
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EventCalender()))  ,
                child: itemBox(s1: "Event", s2: "Calendar",iconData:"assets/images/cal.png",)),
              
      
            ],
          ),
        ),

      ],
    ),
      ),
    );
  }
}

