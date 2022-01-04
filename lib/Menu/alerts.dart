import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

import 'more_info_car.dart';
import 'more_info_flight.dart';
import 'more_info_goods.dart';
import 'more_info_repost.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  var array, array1, array2, array3, array4;

  Future getData() async {
    //Flights
    var _doc = await FirebaseFirestore.instance
        .collection("PrivateCharter")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    if (docStatus == true) {
      array1 = _doc.data()!['Flight'];
      // print(array1.length);
      if (array == null)
        array = array1;
      else
        array += array1;
    }

    //Cars
    _doc = await FirebaseFirestore.instance
        .collection("LuxuryGoods")
        .doc(UserDetails.uid)
        .get();
    docStatus = _doc.exists;
    if (docStatus == true) {
      array2 = _doc.data()!['Goods'];
      // print(array2.length);
      if (array == null)
        array = array2;
      else
        array += array2;
    }

    //Goods
    _doc = await FirebaseFirestore.instance
        .collection("CarRental")
        .doc(UserDetails.uid)
        .get();
    docStatus = _doc.exists;
    if (docStatus == true) {
      array3 = _doc.data()!['Car'];
      // print(array3.length);
      if (array == null)
        array = array3;
      else
        array += array3;
    }

    //Repost Requests
    _doc = await FirebaseFirestore.instance
        .collection("RepostRequests")
        .doc(UserDetails.uid)
        .get();
    docStatus = _doc.exists;
    if (docStatus == true) {
      array4 = _doc.data()!['Repost'];
      // print(array3.length);
      if (array == null)
        array = array4;
      else
        array += array4;
    }

    print(array.length);

    if (array != null) {
      // print("Final Array Size : ${array.length}");
      //Sorting
      array.sort(
        (a, b) {
          return b['createdAt'].toString().toLowerCase().compareTo(
                a['createdAt'].toString().toLowerCase(),
              );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text("ALERTS", style: myStyle(55, "Bizmo")),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return array == null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .3,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.frown,
                                    size: 45,
                                  ),
                                  SizedBox(height: 15),
                                  Center(
                                    child: Text(
                                      "There is Nothing here...",
                                      textAlign: TextAlign.center,
                                      style: myStyle(20, 'Bizmo'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  array.length == null ? 0 : array.length,
                              itemBuilder: (context, index) {
                                // print(
                                //     "${array[index]['Status']} -> ${array[index]['Type']}");
                                return array[index]['Status'] == 'Pending'
                                    ? SizedBox(height: 0)
                                    : Column(
                                        children: [
                                          SizedBox(height: 10),
                                          item(
                                            s1: array[index]['Type'] !=
                                                    "Repost"
                                                ? "Concierge - ${array[index]['Type']}"
                                                : array[index]['Type'],
                                            s2: array[index]['Status'],
                                            s3: array[index]['Update'] == null
                                                ? null
                                                : array[index]['Update'],
                                            ontap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => array[
                                                                  index]
                                                              ['Type'] ==
                                                          'Goods'
                                                      ? MoreInfoGoods(
                                                          index: index,
                                                          array: array,
                                                        )
                                                      : array[index]
                                                                  ['Type'] ==
                                                              'Flight'
                                                          ? MoreInfoFlights(
                                                              array: array,
                                                              index: index)
                                                          : array[index][
                                                                      'Type'] ==
                                                                  'Repost'
                                                              ? MoreInfoRepost(
                                                                  array:
                                                                      array,
                                                                  index:
                                                                      index)
                                                              : MoreInfoCar(
                                                                  array:
                                                                      array,
                                                                  index:
                                                                      index),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                              },
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

class item extends StatelessWidget {
  final String s1, s2;
  final s3;
  final Function()? ontap;

  const item({
    Key? key,
    required this.s1,
    required this.s2,
    this.ontap,
    this.s3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var updates = s3;
    String latest_update = (s3 == null || s3.length == 0)
        ? "NO Update yet!"
        : updates[updates.length - 1]['Message'];
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: ontap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s1,
                        style: myStyle(20, "Bizmo"),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              "${s2} - ${latest_update}",
                              maxLines: 1,
                              style: myStyle(15, "Bizmo2"),
                            ),
                          ),
                          latest_update == "NO Update yet!"
                              ? SizedBox(width: 0)
                              : Text(
                                  "....",
                                  maxLines: 1,
                                  style: myStyle(15, "Bizmo2"),
                                ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.play_arrow_outlined,
                size: 50,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
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
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
