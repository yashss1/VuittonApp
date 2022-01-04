import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vuitton_club/Menu/profile.dart';
import 'package:vuitton_club/Onboarding/profile_signup.dart';
import 'package:vuitton_club/Services/get_user_data.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

enum Status { Waiting, Error }

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  String smsCode = "";

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode = "456789";

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    print(widget.phone);
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            print('User Logged In');
            if (value.additionalUserInfo!.isNewUser) {
              print('New User');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSignUp(
                            phone: widget.phone,
                          )),
                  (route) => false);
            } else {
              print('Old User');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GetUserData(),
                ),
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${e.message}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  Widget otpField() {
    return PinCodeTextField(
      length: 6,
      textStyle: myStyle(35, 'Bizmo'),
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        selectedColor: Colors.black,
        fieldHeight: 50,
        fieldWidth: 45,
        activeFillColor: Colors.transparent,
        borderWidth: 5,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: false,
      cursorColor: Colors.black,
      cursorHeight: 35,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
        setState(() {
          smsCode = value;
        });
      },
      appContext: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: screen_color,
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                "assets/images/lv logo 2.png",
                height: 325,
                width: 325,
              ),
              alignment: Alignment.topLeft,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 240, left: 22, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("VERIFY", style: myStyle(55, "Bizmo")),
                    Container(
                      child: Text("Enter your OTP code",
                          style: myStyle(
                            20,
                            "Bizmo2",
                          )),
                    ),
                    SizedBox(height: 30),
                    otpField(),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                       width: double.infinity,
                      alignment: Alignment.center,
                      child: button(
                        onPressed: () async {
                          print(smsCode);

                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode,
                                        smsCode: smsCode))
                                .then((value) async {
                              print('User Logged In');
                              if (value.additionalUserInfo!.isNewUser) {
                                print('New User');
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileSignUp(
                                              phone: widget.phone,
                                            )),
                                    (route) => false);
                              } else {
                                print('Old User');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetUserData(),
                                  ),
                                );
                              }
                            });
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            _scaffoldkey.currentState!.showSnackBar(
                                SnackBar(content: Text('Invalid OTP')));
                          }
                        },
                        child: Text("CONTINUE"),

                        
                       
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
