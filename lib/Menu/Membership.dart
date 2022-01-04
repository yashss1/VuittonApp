import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Networking/rolodex.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  bool showSpinner = false;
  var temp;

  Future unlink_license() async {
    setState(() {
      showSpinner = true;
    });
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    String? uid = UserDetails.uid;

    userCollection.doc(uid).set({
      "License": {
        "Key": "",
      },
    }, SetOptions(merge: true)).then((value) {
      setState(() {
        showSpinner = false;
      });
      print('License Key Unlinked');
    }).catchError((error) {
      print('Error unlinking the License key');
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
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false),
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
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bizmo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   "EXPIRES: 01/20/2022",
                          //   style: myStyle(13, 'Bizmo2'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                      child: Text("GO TO DASHBOARD"),

                      // ignore: prefer_const_constructors
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Rolodex()),
                        );
                      },
                      child: Text("GO TO COMMUNITY"),

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 5.0,
                          color: Colors.black,
                        ),
                        primary: screen_color,
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        unlink_license();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => License_Key(),
                            ),
                            (route) => false);
                      },
                      child: Text("UNLINK LICENSE"),

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
                ],
              ),
            ),
          ),
        ));
  }
}
