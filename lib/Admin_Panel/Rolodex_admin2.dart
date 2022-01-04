import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Admin_Panel/Rolodex_admin.dart';
import 'package:vuitton_club/contants.dart';

class RolodexAdmin2 extends StatefulWidget {
  const RolodexAdmin2({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _RolodexAdmin2State createState() => _RolodexAdmin2State();
}

class _RolodexAdmin2State extends State<RolodexAdmin2> {
  bool showSpinner = false;

  var temp;

  Future banUser() async {
    setState(() {
      showSpinner = true;
    });
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = widget.array[widget.index]['Info']['Uid'];

    userCollection.doc(uid).set({
      "License": {
        "Status": "Ban",
      },
    }, SetOptions(merge: true)).then((value) {
      setState(() {
        showSpinner = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "User Banned",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to Ban User",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${widget.array[widget.index]['Info']['Name']}",
                                    style: myStyle(24, 'Bizmo'),
                                  ),
                                ],
                              ),
                              widget.array[widget.index]['Info']
                                          ['JobTitle'] ==
                                      ''
                                  ? Text(" ---- ",
                                      style: myStyle(15, "Bizmo2"))
                                  : Text(
                                      "${widget.array[widget.index]['Info']['JobTitle']}",
                                      style: myStyle(15, "Bizmo2"),
                                    ),
                              Text(
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
                                  Text(
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
                                  Text(
                                    "${widget.array[widget.index]['Info']['PhoneNumber']}",
                                    style: myStyle(15, "Bizmo2"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  widget.array[widget.index]['Info']
                                              ['InstaId'] ==
                                          ''
                                      ? Text(" ---- ",
                                          style: myStyle(15, "Bizmo2"))
                                      : Text(
                                          "${widget.array[widget.index]['Info']['InstaId']}",
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
                        padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                        child: Column(
                          children: [
                            items(
                              s1: "Device: ",
                              s2: "${widget.array[widget.index]['Info']['DeviceModel']}",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            items(
                              s1: "IP: ",
                              s2: "${widget.array[widget.index]['Info']['IP']}",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            items(
                              s1: "Current Membership: ",
                              s2: "${widget.array[widget.index]['License']['Status']}",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            // items(
                            //   s1: "Expires: ",
                            //   s2: "10/20/2022",
                            // ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        banUser();
                      },
                      child: Text("BAN FROM APP"),
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 5.0,
                            color: Colors.black,
                          ),
                          primary: Color(0xFFEB5B44),
                          onPrimary: Colors.white,
                          textStyle: TextStyle(
                            fontFamily: "Bizmo2",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 26,
                          ),
                          fixedSize: Size(320, 67),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class items extends StatelessWidget {
  final String s1, s2;

  items({
    Key? key,
    required this.s1,
    required this.s2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          s1,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Bizmo2',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          s2,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Bizmo2',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
