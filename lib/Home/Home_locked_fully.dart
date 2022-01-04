import 'package:flutter/material.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/box.dart';

class HomeLockedFully extends StatefulWidget {
  const HomeLockedFully({Key? key}) : super(key: key);

  @override
  _HomeLockedFullyState createState() => _HomeLockedFullyState();
}

class _HomeLockedFullyState extends State<HomeLockedFully> {
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
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
                  ),
                  itemBox(
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
                  ),
                  itemBox(
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
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
                  itemBox(
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
                  ),
                  itemBox(
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
                  ),
                  itemBox(
                    s1: "*******",
                    s2: "*********",
                    iconData: "assets/images/lock.png",
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
