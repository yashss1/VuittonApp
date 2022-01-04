import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/Networking/Event_calender.dart';
import 'package:vuitton_club/Networking/rolodex.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/box.dart';

class HomeLocked extends StatefulWidget {
  const HomeLocked({Key? key}) : super(key: key);

  @override
  _HomeLockedState createState() => _HomeLockedState();
}

class _HomeLockedState extends State<HomeLocked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screen_color,
      body: Container(
    margin: EdgeInsets.only(top: top_margin, left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Center(
              child: Text(
                "VUITTON CLUB",
                style: myStyle(25, 'Bizmo'),
              ),
            ),
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
                    'assets/images/Member_Monthly 1.png',
                    height: 80,
                    width: 180,
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
              itemBox(
                s1: "Plane",
                s2: "Charter",
                
                    iconData:
                  "assets/images/lock.png",
                 
              ),
              itemBox(
                s1: "Luxury",
                s2: "Goods",
               
                    iconData: 
                  "assets/images/lock.png",
                  
              ),
              itemBox(
                  s1: "Car",
                  s2: "Rental",
                  
                      iconData: 
                    "assets/images/lock.png",
                   
                 ),
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Rolodex())),
                child: itemBox(
                  s1: "Club",
                  s2: "Rolodex",
                 
                      iconData: 
                    "assets/images/card.png",
                    
                ),
              ),
              itemBox(
                s1: "Repost",
                s2: "Request",
               
                    iconData: 
                  "assets/images/lock.png",
                  
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventCalender2())),
                child: itemBox(
                  s1: "Events",
                  s2: "",
                  
                      iconData: 
                    "assets/images/cal.png",
                    ),
                ),
             
            ],
          ),
        ),
      ],
    ),
      ),
    );
  }
}

