import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_public_api/insta_public_api.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class RolodexIndividual extends StatefulWidget {
  const RolodexIndividual({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _RolodexIndividualState createState() => _RolodexIndividualState();
}

class _RolodexIndividualState extends State<RolodexIndividual> {
  FlutterInsta flutterInsta = new FlutterInsta();

  // Click on Club Rolodex to call this function
  Future getInstaData(String username) async {
    await flutterInsta.getProfileData("cristiano");
    print(flutterInsta.username);
    print(flutterInsta.bio);
    print(flutterInsta.imgurl);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false),
                        child: Icon(
                          Icons.close_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                    onTap: () async {
                      if (widget.array[widget.index]['DataShared']['InstaId'] ==
                              true &&
                          UserDetails.insta_id != "") {
                        getInstaData(widget.array[widget.index]['Info']
                                ['InstaId']
                            .toString());
                      }
                    },
                    child: Text("CLUB\nROLODEX", style: myStyle(55, "Bizmo"))),
                Text("VUITTON CLUB", style: myStyle(25, "Bizmo2")),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: button_color,
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.array[widget.index]['Info']['Name']}",
                                  style: myStyle(24, 'Bizmo'),
                                ),
                              ],
                            ),
                            widget.array[widget.index]['DataShared']
                                        ['JobTitle'] ==
                                    false
                                ? Text(
                                    "Club Member",
                                    style: myStyle(15, "Bizmo2"),
                                  )
                                : Text(
                                    "${widget.array[widget.index]['Info']['JobTitle']}",
                                    style: myStyle(15, "Bizmo2"),
                                  ),
                            widget.array[widget.index]['DataShared']
                                        ['Location'] ==
                                    false
                                ? Text(
                                    "Worldwide",
                                    style: myStyle(15, "Bizmo2"),
                                  )
                                : Text(
                                    "${widget.array[widget.index]['Info']['Location']}",
                                    style: myStyle(15, "Bizmo2"),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.envelope,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                widget.array[widget.index]['DataShared']
                                            ['Email'] ==
                                        false
                                    ? Text("HIDDEN",
                                        style: myStyle(15, "Bizmo2"))
                                    : Text(
                                        "${widget.array[widget.index]['Info']['Email']}",
                                        style: myStyle(15, "Bizmo2"),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_phone_outlined,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                widget.array[widget.index]['DataShared']
                                            ['PhoneNumber'] ==
                                        false
                                    ? Text("HIDDEN",
                                        style: myStyle(15, "Bizmo2"))
                                    : Text(
                                        "${widget.array[widget.index]['Info']['PhoneNumber']}",
                                        style: myStyle(15, "Bizmo2"),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ]),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: double.infinity,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: button_color,
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 20),
                      child: (widget.array[widget.index]['DataShared']
                                      ['InstaId'] ==
                                  false ||
                              UserDetails.insta_id == "")
                          ? Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.instagram,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("HIDDEN", style: myStyle(15, "Bizmo2")),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.instagram,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.array[widget.index]['Info']
                                          ['InstaId'],
                                      style: myStyle(15, "Bizmo2"),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80",
                                      width: 120,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BIO",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
