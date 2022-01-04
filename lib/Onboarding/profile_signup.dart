import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/get_user_data.dart';
import 'package:vuitton_club/Services/store_user_info.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/textfield.dart';

class ProfileSignUp extends StatefulWidget {
  const ProfileSignUp({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _ProfileSignUpState createState() => _ProfileSignUpState();
}

class _ProfileSignUpState extends State<ProfileSignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            color: screen_color,
            child: Stack(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/lv logo 1.png",
                    height: 325,
                    width: 325,
                  ),
                  alignment: Alignment.topLeft,
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 180, left: 22, right: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PROFILE", style: myStyle(55, "Bizmo")),
                        Container(
                          child: Text("Enter your profile details",
                              style: myStyle(
                                20,
                                "Bizmo2",
                              )),
                        ),
                        SizedBox(height: 30),
                        Text("Full Name",
                            style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                        SizedBox(
                          height: 5,
                        ),
                        textfield(hint_text: 'John Doe', controller: name),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Email",
                            style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                        SizedBox(
                          height: 5,
                        ),
                        textfield(
                            hint_text: 'jdoe@gmail.com', controller: email),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Location",
                            style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                        SizedBox(
                          height: 5,
                        ),
                        textfield(hint_text: 'Miami, FL', controller: location),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                           width: double.infinity,
                          alignment: Alignment.center,
                          child: button(
                            onPressed: () async {
                              if (name.text == null || name.text.length==0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Full Name is Null",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (email.text == null || email.text.length==0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Email is Null",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (location.text == null || location.text.length==0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Location is Null",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  showSpinner = true;
                                });
                                await StoreUserInfo().storeUserDetails(
                                    email.text,
                                    name.text,
                                    widget.phone,
                                    location.text);
                                await StoreUserInfo().storeUserDeviceInfo();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetUserData(),
                                  ),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            child: Text("CONTINUE"),
                            // ignore: prefer_const_constructors
                            
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
