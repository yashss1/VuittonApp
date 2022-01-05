import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/Networking/rolodex.dart';
import 'package:vuitton_club/Services/store_user_info.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/box.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool p1 = true, p2 = true, p3 = false, p4 = false, p5 = false, p6 = false;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    p1 = UserDetails.dsName!;
    p2 = UserDetails.dsEmail!;
    p3 = UserDetails.dsPhone!;
    p4 = UserDetails.dsInsta_id!;
    p5 = UserDetails.dsJob_title!;
    p6 = UserDetails.dsLocation!;
  }

  @override
  Widget build(BuildContext context) {
    final bool clubRolodexVisited = true;

    return Scaffold(
        backgroundColor: screen_color,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
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
                  clubRolodexVisited == false
                      ? Text("CLUB\nROLODEX", style: myStyle(55, "Bizmo"))
                      : Text("ROLODEX\nSETTINGS", style: myStyle(55, "Bizmo")),
                  Container(
                    child: Text(
                        "Select What Info You Want to Share With Other Members",
                        style: myStyle(
                          17,
                          "Bizmo2",
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          itemBox(
                            s1: "Name\n(Required)",
                            iconData: "assets/images/card.png",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Name is Required",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: p1 ? Colors.black : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: p1
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          itemBox(
                            s1: "Email\n",
                            iconData: "assets/images/mail.png",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                p2 = !p2;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: p2 ? Colors.black : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: p2
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            itemBox(
                              s1: "Phone\n",
                              iconData: "assets/images/phone.png",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  p3 = !p3;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color:
                                        p3 ? Colors.black : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: p3
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : null,
                              ),
                            )
                          ],
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
                      Column(
                        children: [
                          itemBox(
                            s1: "Social @",
                            iconData: "assets/images/insta.png",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                p4 = !p4;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: p4 ? Colors.black : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: p4
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          itemBox(
                            s1: "Job Title",
                            iconData: "assets/images/bag.png",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                p5 = !p5;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: p5 ? Colors.black : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: p5
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          itemBox(
                            s1: "Location",
                            iconData: "assets/images/location.png",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                p6 = !p6;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: p6 ? Colors.black : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: p6
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () async {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Rolodex()));

                        setState(() {
                          showSpinner = true;
                        });
                        // UserPreferences.setClubRolodexVisited();
                        await StoreUserInfo()
                            .storeUserDataSharedDetails(p1, p2, p3, p4, p5, p6);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Menu(),
                          ),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      child: Text("SAVE"),

                      // ignore: prefer_const_constructors
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
