import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vuitton_club/widgets/textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Home/Home_locked_fully.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Home/home_locked.dart';
import 'package:vuitton_club/Services/networking.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class License_Key extends StatefulWidget {
  const License_Key({Key? key}) : super(key: key);

  @override
  _License_KeyState createState() => _License_KeyState();
}

class _License_KeyState extends State<License_Key> {
  TextEditingController license_key = TextEditingController();
   String _url = 'https://thevuittonclub.com/';

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState() {
    super.initState();
    // UserPreferences.getJsonData({"info":false});
  }

  bool showSpinner = false;

  var temp;

  Future storeKey() async {
    setState(() {
      showSpinner = true;
    });
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    String? uid = UserDetails.uid;

    userCollection.doc(uid).set({
      "License": {
        "Status":
            UserDetails.license_data!['plan']['name'].contains('Social') == true
                ? "Social"
                : "Member",
        "Key": license_key.text,
      },
    }, SetOptions(merge: true)).then((value) {
      setState(() {
        showSpinner = false;
      });
      print('Key Stored');
    }).catchError((error) {
      print('Error Storing Key');
    });
  }

  void getData() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.hyper.co/v6/licenses/${license_key.text}');
    print('https://api.hyper.co/v6/licenses/${license_key.text}');
    var license_data = await networkHelper.getData();
    // print(license_data);
    if (license_data != null) {
      UserDetails.license_data = license_data;
      storeKey();
      // print(UserDetails.license_data);
      if (license_data['status'] != "active") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "License Inactive",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }
      if (license_data['plan']['name'].contains('Social') == true) {
        setState(() {
          showSpinner = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeLocked(),
          ),
        );
      }
    } else {
      setState(() {
        showSpinner = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Incorrect Key",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
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
                    child: Icon(
                      Icons.close,
                      size: 50,
                    ),
                    alignment: Alignment.topRight,
                  ),
                  Text("JOIN \nVUITTON \nCLUB", style: myStyle(55, "Bizmo")),
                  Container(
                    child: Text(
                        "Link Your License Key, or visit our website to purchase one.",
                        style: myStyle(
                          20,
                          "Bizmo2",
                        )),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: textfield(
                        hint_text: 'XXXX-XXXX-XXXX-XXXX',
                        controller: license_key,
                        size: 21),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () {
                        if (license_key.text.isEmpty == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter a valid License Key",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                          getData();
                        }
                      },
                      child: Text("LINK MEMBERSHIP"),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        _launchURL();
                      },
                      child: Text("GO TO WEBSITE"),

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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeLockedFully())),
                      child: Text("Skip for now",
                          style: myStyle(
                            16,
                            "Bizmo2",
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
