// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/ban_page.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/checking_license2.dart';
import 'package:vuitton_club/contants.dart';
import 'networking.dart';

class CheckUserLicense extends StatelessWidget {

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

          String key = data['License']['Key'].toString();
          String status = data['License']['Status'].toString();

          // Checking Ban & Full Access
          if (status == 'Ban') {
            return BanPage();
          }
          if (key == "") {
            return License_Key();
          }
          return CheckUserLicense2(lic_key: key);
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
