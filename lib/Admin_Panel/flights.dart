import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/Admin_Panel/individual_info.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  _FlightsState createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  List l1 = [], l2 = [];

  Future<List> getData() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('PrivateCharter').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        l2 = data['Flight'];
        if (l1 == null) {
          l1 = l2;
        } else {
          l1 += l2;
        }
      }

      // print(l1.length);
      // print(l1);
      if (l1 != null) {
        //Sorting
        l1.sort(
          (a, b) {
            return b['createdAt'].toString().toLowerCase().compareTo(
                  a['createdAt'].toString().toLowerCase(),
                );
          },
        );
      }
    });
    return l1;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Text("FLIGHTS", style: myStyle(55, "Bizmo")),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder<List>(
                    future: getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List list = snapshot.data ?? [];
                      // print("List Length : ${list.length}");
                      return list.length == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .3,
                              ),
                              child: Column(
                                children: [
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
                                  list.length == null ? 0 : list.length,
                              itemBuilder: (context, index) {
                                // print(array[index]);
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Individualnfo(
                                              array: l1,
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: block(
                                        list[index]['Status'],
                                        list[index]['UserName'],
                                        list[index]['Date'],
                                        list[index]['time'],
                                        list[index]['Passengers'],
                                        list[index]['DepartureCode'],
                                        list[index]['ArrivalCode'],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Container block(String status, String name, String date, String time,
      String passengers, String from_city, String to_city) {
    return Container(
      width: double.infinity,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: button_color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 15, 30, 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Charter Request",
            style: myStyle(20, 'Bizmo'),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "STATUS : ${status}",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Bizmo2',
              fontWeight: FontWeight.bold,
            ),
          ),
          items(
            s1: "Member: ",
            s2: "${name}",
          ),
          items(
            s1: "Date: ",
            s2: "${date} ${time}",
          ),
          items(
            s1: "Passengers: ",
            s2: "${passengers}",
          ),
          items(
            s1: "From: ${from_city} -> ",
            s2: "${to_city}",
          ),
        ]),
      ),
    );
  }
}

class items extends StatelessWidget {
  final String s1, s2;

  items({
    Key? key,
    required this.s1,
    required this.s2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          s1,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Bizmo2',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          s2,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Bizmo2',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
