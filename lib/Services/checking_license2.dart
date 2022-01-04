import 'package:flutter/material.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Home/home_locked.dart';
import 'package:vuitton_club/Onboarding/license_key.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

import 'networking.dart';

class CheckUserLicense2 extends StatefulWidget {
  const CheckUserLicense2({Key? key, required this.lic_key}) : super(key: key);
  final String lic_key;

  @override
  State<CheckUserLicense2> createState() => _CheckUserLicense2State();
}

class _CheckUserLicense2State extends State<CheckUserLicense2> {
  @override
  Widget build(BuildContext context) {
    Future getData() async {
      NetworkHelper networkHelper =
          NetworkHelper('https://api.hyper.co/v6/licenses/${widget.lic_key}');
      print('https://api.hyper.co/v6/licenses/${widget.lic_key}');
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
              ),
              (route) => false);
        }
        if (license_data['plan']['name'].contains('Social') == true) {
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
      }
    }

    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
        }
        return License_Key();
      },
    );
  }
}
