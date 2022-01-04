import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key, this.userArray, this.index}) : super(key: key);

  final userArray, index;

  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  var array, array1, array2, array3, array4;

  Future getData() async {
    //Flights
    var _doc = await FirebaseFirestore.instance
        .collection("PrivateCharter")
        .doc(widget.userArray[widget.index]['Info']['Uid'])
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
        .doc(widget.userArray[widget.index]['Info']['Uid'])
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
        .doc(widget.userArray[widget.index]['Info']['Uid'])
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
        .doc(widget.userArray[widget.index]['Info']['Uid'])
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

    // print(array.length);

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
                      child: Icon(
                        Icons.close,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                Text("MEMBER\nREQUESTS", style: myStyle(55, "Bizmo")),
                SizedBox(
                  height: 10,
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
                          ? Container()
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  array.length == null ? 0 : array.length,
                              itemBuilder: (context, index) {
                                // print(array[index]);
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    block(mp: array[index]),
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
}

class block extends StatelessWidget {
  final mp;

  block({
    Key? key,
    required this.mp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "${mp['Type']} Request",
              style: myStyle(20, 'Bizmo'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Status : ${mp['Status']}",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Bizmo2',
                fontWeight: FontWeight.bold,
              ),
            ),
            mp['Type'] == "Repost"
                ? items(
                    s1: "Member : ",
                    s2: "${mp['UserName']}",
                  )
                : mp['Type'] == "Car"
                    ? items(
                        s1: "Member : ",
                        s2: "${mp['UserName']}",
                      )
                    : mp['Type'] == "Flight"
                        ? SizedBox(height: 0)
                        : items(
                            s1: "Member : ",
                            s2: "${mp['UserName']}",
                          ),
            mp['Type'] == "Repost"
                ? items(
                    s1: "Instagram Handle : ",
                    s2: "${mp['InstaHandle']}",
                  )
                : mp['Type'] == "Car"
                    ? items(
                        s1: "Date : ",
                        s2: "${mp['Date']}",
                      )
                    : mp['Type'] == "Goods"
                        ? items(
                            s1: "Item Name : ",
                            s2: "${mp['ItemName']}",
                          )
                        : items(
                            s1: "From : ",
                            s2: "${mp['DepartureCode']} -> ${mp['ArrivalCode']}",
                          ),
            mp['Type'] == "Repost"
                ? items(
                    s1: "URL : ",
                    s2: "${mp['URL']}",
                  )
                : mp['Type'] == "Car"
                    ? items(
                        s1: "Drop : ",
                        s2: "${mp['Location']}",
                      )
                    : mp['Type'] == "Goods"
                        ? items(
                            s1: "Size : ",
                            s2: "${mp['Size']}",
                          )
                        : items(
                            s1: "Date : ",
                            s2: "${mp['Date']}",
                          ),
            mp['Type'] == "Repost"
                ? SizedBox(height: 0)
                : mp['Type'] == "Car"
                    ? items(
                        s1: "Budget : ",
                        s2: "${mp['Budget']}",
                      )
                    : mp['Type'] == "Goods"
                        ? items(
                            s1: "Budget : ",
                            s2: "${mp['Budget']}",
                          )
                        : items(
                            s1: "Passengers : ",
                            s2: "${mp['Passengers']}",
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
