import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:vuitton_club/Services/user_details.dart';

class StoreUserInfo {
  //getUserDetails
  Future<void> storeUserDetails(email, name, phone, location) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection
        .doc(uid)
        .set({
          "Info": {
            "Name": name,
            "Email": email,
            "PhoneNumber": phone,
            "Uid": uid,
            "IsAdmin": false,
            "Location": location,
            "InstaId": "",
            "JobTitle": "",
          },
          "DataShared": {
            "Name": true,
            "Email": false,
            "PhoneNumber": false,
            "Location": false,
            "InstaId": false,
            "JobTitle": false,
          },
          "License": {
            "Status": "None",
            "Key": "",
          },
        }, SetOptions(merge: true))
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return;
  }

  Future<void> storeUserDetailsUpdated(
      email, name, location, insta_id, job_title, isAdmin) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection
        .doc(uid)
        .set({
          "Info": {
            "Name": name,
            "Email": email,
            "Uid": uid,
            "IsAdmin": isAdmin,
            "Location": location,
            "InstaId": insta_id,
            "JobTitle": job_title,
          },
        }, SetOptions(merge: true))
        .then((value) => print("User Details Updated"))
        .catchError((error) => print("Failed to Update user details: $error"));
    return;
  }

  Future<void> storeUserDataSharedDetails(
      name, email, phone, insta_id, job_title, location) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    UserDetails.dsName = name;
    UserDetails.dsEmail = email;
    UserDetails.dsPhone = phone;
    UserDetails.dsInsta_id = insta_id;
    UserDetails.dsJob_title = job_title;
    UserDetails.dsLocation = location;
    userCollection
        .doc(uid)
        .set({
          "DataShared": {
            "Name": name,
            "Email": email,
            "PhoneNumber": phone,
            "Location": location,
            "InstaId": insta_id,
            "JobTitle": job_title,
          },
        }, SetOptions(merge: true))
        .then((value) => print("Shared Data details Updated"))
        .catchError((error) => print("Failed to Update Data: $error"));
    return;
  }

  Future<void> storeUserDeviceInfo() async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    //Ip Address
    String ip = '';
    final ipv4 = await Ipify.ipv4();
    ip = ipv4;
    print("IpV4 -> " + ip);
    // Device Info
    String model = '';
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        model = androidInfo.model;
        print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        model = iosInfo.utsname.machine;
        print('Running on ${iosInfo.utsname.machine}'); // e.g.  "iPod7,1"
      }
    } on PlatformException {
      print("Coluld not get Device Information");
    }

    userCollection
        .doc(uid)
        .set({
          "Info": {
            'DeviceModel': model,
            'IP': ip,
          },
        }, SetOptions(merge: true))
        .then((value) => print("User Device Data uploaded"))
        .catchError(
            (error) => print("Failed to Store User Device Data: $error"));
    return;
  }
}
