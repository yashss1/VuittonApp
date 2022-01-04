import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/Home_locked_fully.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Home/home_locked.dart';
import 'package:vuitton_club/Menu/menu.dart';
import 'package:vuitton_club/Services/store_user_info.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/textfield.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController insta_id = TextEditingController();
  TextEditingController job_title = TextEditingController();

  @override
  void initState() {
    super.initState();
    // print(UserDetails.name);
  }

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    return Scaffold(
        backgroundColor: screen_color,
        body: SingleChildScrollView(
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
                Text("PROFILE", style: myStyle(55, "Bizmo")),
                SizedBox(height: 20),
                Text("Full Name",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                textfield(
                    hint_text: 'John Doe',
                    controller: name..text = UserDetails.name!),
                SizedBox(
                  height: 10,
                ),
                Text("Email",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                textfield(
                    hint_text: "jdoe@gmail.com",
                    controller: email..text = UserDetails.email!),
                SizedBox(
                  height: 10,
                ),
                Text("Location",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                textfield(
                    hint_text: 'Miami, FL',
                    controller: location..text = UserDetails.location!),
                SizedBox(
                  height: 10,
                ),
                Text("Phone",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Phone Number cannot be changed",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black, width: 5.0),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        UserDetails.phone!,
                        style: myStyle(20, "Bizmo", color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Instagram Handle (optional)",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                textfield(
                    hint_text: '@thevuittonclub',
                    controller: insta_id..text = UserDetails.insta_id!),
                SizedBox(
                  height: 10,
                ),
                Text("Job Title (optional)",
                    style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                SizedBox(
                  height: 5,
                ),
                textfield(
                    hint_text: 'Club Member',
                    controller: job_title..text = UserDetails.job_title!),
                SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (email.text.contains(".") &&
                          email.text.contains("@")) {
                        setState(() {
                          showSpinner = true;
                        });
                        UserDetails.name = name.text;
                        UserDetails.email = email.text;
                        UserDetails.location = location.text;
                        UserDetails.insta_id = insta_id.text;
                        UserDetails.job_title = job_title.text;
                        await StoreUserInfo().storeUserDetailsUpdated(
                          email.text,
                          name.text,
                          location.text,
                          insta_id.text,
                          job_title.text,
                          UserDetails.isAdmin,
                        );
                        if (UserDetails.license_data!['status'] != "active") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeLockedFully(),
                              ),
                              (route) => false);
                        }
                        if (UserDetails.license_data!['plan']['name']
                                .contains('Social') ==
                            true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                              (route) => false);
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeLocked(),
                              ),
                              (route) => false);
                        }
                        UserDetails.insta_id = insta_id.text;
                        UserDetails.job_title = job_title.text;
                        setState(() {
                          showSpinner = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Invalid Email",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Update"),
                    // ignore: prefer_const_constructors
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
