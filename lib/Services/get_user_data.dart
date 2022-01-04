import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/checking_license.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class GetUserData extends StatelessWidget {
  Future doExist() async {
    var _doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    bool docStatus = _doc.exists;
    // print(docStatus);
    if (docStatus == false) {}
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    String documentId = uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
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

          return CheckUserLicense();
        }
        return Scaffold(
          backgroundColor: screen_color,
          body: Center(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
