import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Menu/more_info_car.dart';
import 'package:vuitton_club/Menu/more_info_flight.dart';
import 'package:vuitton_club/Menu/more_info_goods.dart';
import 'package:vuitton_club/Menu/more_info_repost.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    print(array);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
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
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                      (route) => false),
                  child: Icon(
                    Icons.close,
                    size: 50,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
              Text(
                "HISTORY",
                style: myStyle(55, "Bizmo"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                              // print(array[index]);
                              return Column(
                                children: [
                                  SizedBox(height: 10),
                                  item(
                                    s1: array[index]['Type'] != "Repost"
                                        ? "Concierge - ${array[index]['Type']}"
                                        : array[index]['Type'],
                                    s2: array[index]['Type'] == "Goods"
                                        ? "${array[index]['ItemName']}"
                                        : array[index]['Type'] == "Repost"
                                            ? "${array[index]['InstaHandle']}"
                                            : "${array[index]['Date']}",
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              array[index]['Type'] == 'Goods'
                                                  ? MoreInfoGoods(
                                                      index: index,
                                                      array: array,
                                                    )
                                                  : array[index]['Type'] ==
                                                          'Flight'
                                                      ? MoreInfoFlights(
                                                          array: array,
                                                          index: index)
                                                      : array[index]
                                                                  ['Type'] ==
                                                              'Repost'
                                                          ? MoreInfoRepost(
                                                              array: array,
                                                              index: index)
                                                          : MoreInfoCar(
                                                              array: array,
                                                              index: index),
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
      ),
    );
  }
}

class item extends StatelessWidget {
  final String s1, s2;
  final Function()? ontap;

  const item({
    Key? key,
    required this.s1,
    required this.s2,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: ontap,
        child: Padding(
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
                  Text(
                    s2,
                    style: myStyle(15, "Bizmo2"),
                  )
                ],
              ),
              Icon(
                Icons.play_arrow_outlined,
                size: 50,
              ),
            ],
          ),
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
