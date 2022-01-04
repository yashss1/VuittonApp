import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/contants.dart';

import 'individual_info.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  var array, arr;

  Future getData() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('CarRental').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        arr = data['Car'];
        if (array == null) {
          array = arr;
        } else {
          array += arr;
        }
      }

      if (array != null) {
        //Sorting
        array.sort(
          (a, b) {
            return b['createdAt'].toString().toLowerCase().compareTo(
                  a['createdAt'].toString().toLowerCase(),
                );
          },
        );
      }
    });
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
                Text("CARS", style: myStyle(55, "Bizmo")),
                SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Individualnfo())),
                //   child: block()),
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
                                              array: array,
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: block(
                                        array[index]['Status'],
                                        array[index]['UserName'],
                                        array[index]['Date'],
                                        array[index]['time'],
                                        array[index]['Location'],
                                        array[index]['Budget'],
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
      String drop, String budget) {
    return Container(
        width: double.infinity,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: button_color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15, 30, 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Car Request",
              style: myStyle(20, 'Bizmo'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "STATUS: ${status}",
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
              s1: "Drop: ",
              s2: "${drop}",
            ),
            items(
              s1: "Budget: ",
              s2: "\$${budget}",
            ),
          ]),
        ));
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
