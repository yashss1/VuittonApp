import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Onboarding/phone.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vuitton_club/Services/user_details.dart';

import 'package:vuitton_club/Home/ban_page.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';

import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Home/home_locked.dart';

import 'package:connectivity/connectivity.dart';
import 'package:vuitton_club/Services/networking.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  User? user = FirebaseAuth.instance.currentUser;


   checkLicenseDetails(String key) async {

     print('navigating to main page');


     NetworkHelper networkHelper =
     NetworkHelper('https://api.hyper.co/v6/licenses/${key}');
     print('https://api.hyper.co/v6/licenses/${key}');
     var license_data = await networkHelper.getData();

     if (license_data != null) {
       UserDetails.license_data = license_data;
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
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
             builder: (context) => License_Key(),
           ), (route) => false
         );
       }
       if (license_data['plan']['name'].contains('Social') == true) {
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
             builder: (context) => Home(),
           ), (route) => false
         );
       } else {
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
             builder: (context) => HomeLocked(),
           ), (route) => false
         );
       }
     }


   }


  getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    String documentId = uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    var data ;

    data = await users.doc(documentId).get();

    UserDetails.name = data['Info']['Name'].toString();
    UserDetails.email = data['Info']['Email'].toString();
    UserDetails.phone = data['Info']['PhoneNumber'].toString();
    UserDetails.location = data['Info']['Location'].toString();
    UserDetails.isAdmin = data['Info']['IsAdmin'];
    UserDetails.uid = data['Info']['Uid'];
    UserDetails.insta_id = data['Info']['InstaId'];
    UserDetails.job_title = data['Info']['JobTitle'];

    //DataShared
    UserDetails.dsName = data['DataShared']['Name'];
    UserDetails.dsEmail = data['DataShared']['Email'];
    UserDetails.dsPhone = data['DataShared']['PhoneNumber'];
    UserDetails.dsLocation = data['DataShared']['Location'];
    UserDetails.dsInsta_id = data['DataShared']['InstaId'];
    UserDetails.dsJob_title = data['DataShared']['JobTitle'];
    // Checking if Admin
    // Iterating
    print(' user data stored');

    FirebaseFirestore.instance
        .collection('Admins')
        .doc('AllAdmins')
        .get()
        .then(
          (value) =>
          List.from(value.data()!['Admins']).forEach((element) {
            // print(element);
            if (element == UserDetails.phone) {
              UserDetails.isAdmin = true;
              //Updating
              final CollectionReference userCollection =
              FirebaseFirestore.instance.collection('Users');
              userCollection
                  .doc(uid)
                  .set({
                "Info": {
                  "IsAdmin": true,
                },
              }, SetOptions(merge: true))
                  .then((value) => print("User Details Updated"))
                  .catchError((error) =>
                  print("Failed to update user details : $error"));
            }
          }),
    );

    String key = data['License']['Key'].toString();
    String status = data['License']['Status'].toString();

    // Checking Ban & Full Access

    if (status == 'Ban') {

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BanPage()));

    }
    if (key == "") {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => License_Key()));


    }
    else{

      checkLicenseDetails(key);

    }





  }

  Future isLoggedIn() async {
    FirebaseAuth.instance.currentUser!;
  }

  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screen_color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image.asset(
              "assets/images/lv logo 1.png",
              height: 325,
              width: 325,
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            margin: EdgeInsets.only(left: 22, right: 22),
            child: Text("THE \nVUITTON \nCLUB",
                style: myStyle(55, "Bizmo", )),
          ),
          Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              child: Text("CONCIERGE & NETWORK",
                  style: myStyle(
                    24,
                    "Bizmo2",
                  )),
              ),
          SizedBox(
            height: 47,
          ),
          Container(
            width:double.infinity,
            margin: EdgeInsets.only(left: 22, right: 22),
            alignment: Alignment.center,
            child: button(
              onPressed: () async {
                if (user != null) {

                  setState(() {
                    loading=true;
                  });


                  var connectivityResult = await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                    getUserData();
                  } else  {

                    const snackBar = SnackBar(
                      content: Text('Check your internet connection!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }



                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => GetUserData()));





                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhonePage()));
                }
              },
              child: loading? CircularProgressIndicator(color: Colors.white,) :  Text("CONTINUE"),

              // ignore: prefer_const_constructors
              
            ),
          )
        ],
      ),
    );
  }
}
