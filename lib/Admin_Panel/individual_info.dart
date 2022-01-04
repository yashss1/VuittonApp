import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Admin_Panel/Goods.dart';
import 'package:vuitton_club/Admin_Panel/flights.dart';
import 'package:vuitton_club/Admin_Panel/repost.dart';
import 'package:vuitton_club/Admin_Panel/send_update.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

import 'Home_Admin.dart';
import 'cars.dart';

class Individualnfo extends StatefulWidget {
  Individualnfo({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _IndividualnfoState createState() => _IndividualnfoState();
}

class _IndividualnfoState extends State<Individualnfo> {
  bool showSpinner = false;
  var temp;

  Future getData(String collecti, String typ, String status) async {
    // CarRental - Car
    // PrivateCharter - Flight
    // LuxuryGoods - Goods
    // RepostRequests - Repost

    setState(() {
      showSpinner = true;
    });
    String collectionType = collecti;
    String type = typ;
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection(collectionType).get();
    final List<DocumentSnapshot> documents = result.docs;
    // Iterate through all the Documents
    documents.forEach((data) {
      // Iterating
      if (data.id == widget.array[widget.index]['UID']) {
        temp = data[type];

        // Finding the Particular requests in all the arrays of documents
        for (var i = 0; i < temp.length; i++) {
          if (temp[i]['createdAt'] == widget.array[widget.index]['createdAt']) {
            print(temp[i]['Status']);
            temp[i]['Status'] = status;
            print(temp[i]['Status']);
          }
        }

        // Deleting the Document
        FirebaseFirestore.instance
            .collection(collectionType)
            .doc(data.id)
            .delete();

        // Adding the Document again
        FirebaseFirestore.instance.collection(collectionType).doc(data.id).set({
          type: temp,
        }).then((value) {
          setState(() {
            showSpinner = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Status Updated",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => type == 'Car'
                  ? Cars()
                  : type == 'Flight'
                      ? Flights()
                      : type == 'Repost'
                          ? Reposts()
                          : Goods(),
            ),
          );
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.array[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
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
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeAdmin()),
                              (route) => false),
                          child: Icon(
                            Icons.close,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("MORE\nINFO", style: myStyle(55, "Bizmo")),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: button_color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15, 30, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "${widget.array[widget.index]['Type']} REQUEST",
                                  style: myStyle(20, 'Bizmo'),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              items(
                                s1: "Member: ",
                                s2: "${widget.array[widget.index]['UserName']}",
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              widget.array[widget.index]['Type'] == "Goods"
                                  ? items(
                                      s1: "Item Name : ",
                                      s2: "${widget.array[widget.index]['ItemName']}",
                                    )
                                  : widget.array[widget.index]['Type'] ==
                                          "Repost"
                                      ? items(
                                          s1: "Instagram Handle: ",
                                          s2: "${widget.array[widget.index]['InstaHandle']}",
                                        )
                                      : items(
                                          s1: "Date: ",
                                          s2: "${widget.array[widget.index]['Date']} ${widget.array[widget.index]['time']}",
                                        ),
                              SizedBox(
                                height: 4,
                              ),
                              widget.array[widget.index]['Type'] == "Flight"
                                  ? items(
                                      s1: "Pick Up : ",
                                      s2: "${widget.array[widget.index]['DepartureCode']}",
                                    )
                                  : widget.array[widget.index]['Type'] ==
                                          "Goods"
                                      ? items(
                                          s1: "Size : ",
                                          s2: "${widget.array[widget.index]['Size']}",
                                        )
                                      : widget.array[widget.index]['Type'] ==
                                              "Repost"
                                          ? items(
                                              s1: "URL : ",
                                              s2: "${widget.array[widget.index]['URL']}",
                                            )
                                          : items(
                                              s1: "Car Preference : ",
                                              s2: "${widget.array[widget.index]['CarPreference']}",
                                            ),
                              SizedBox(
                                height: 4,
                              ),
                              widget.array[widget.index]['Type'] == "Flight"
                                  ? items(
                                      s1: "Drop Off : ",
                                      s2: "${widget.array[widget.index]['ArrivalCode']}",
                                    )
                                  : widget.array[widget.index]['Type'] ==
                                          "Car"
                                      ? items(
                                          s1: "Drop Off : ",
                                          s2: "${widget.array[widget.index]['Location']}",
                                        )
                                      : widget.array[widget.index]['Type'] ==
                                              "Repost"
                                          ? Container()
                                          : items(
                                              s1: "Link : ",
                                              s2: "${widget.array[widget.index]['Link']}",
                                            ),
                              SizedBox(
                                height: 4,
                              ),
                              widget.array[widget.index]['Type'] == "Flight"
                                  ? items(
                                      s1: "Passengers: ",
                                      s2: "${widget.array[widget.index]['Passengers']} ",
                                    )
                                  : widget.array[widget.index]['Type'] ==
                                          "Repost"
                                      ? Container()
                                      : items(
                                          s1: "Budget : ",
                                          s2: "${widget.array[widget.index]['Budget']}",
                                        ),
                              SizedBox(
                                height: 4,
                              ),
                            ]),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendUpdate(
                                    array: widget.array,
                                    index: widget.index,
                                  ))),
                      // => Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Home())),
                      child: Text("SEND UPDATE"),

                      // ignore: prefer_const_constructors
                      
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        widget.array[widget.index]['Type'] == "Flight"
                            ? getData("PrivateCharter", "Flight", "Booked")
                            : widget.array[widget.index]['Type'] == "Car"
                                ? getData("CarRental", "Car", "Booked")
                                : widget.array[widget.index]['Type'] ==
                                        "Repost"
                                    ? getData(
                                        "RepostRequests", "Repost", "Booked")
                                    : getData(
                                        "LuxuryGoods", "Goods", "Booked");
                      },
                      child: Text("MARK AS BOOKED"),

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 5.0,
                          color: Colors.black,
                        ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        widget.array[widget.index]['Type'] == "Flight"
                            ? getData("PrivateCharter", "Flight", "Shipped")
                            : widget.array[widget.index]['Type'] == "Car"
                                ? getData("CarRental", "Car", "Shipped")
                                : widget.array[widget.index]['Type'] ==
                                        "Repost"
                                    ? getData(
                                        "RepostRequests", "Repost", "Shipped")
                                    : getData(
                                        "LuxuryGoods", "Goods", "Shipped");
                      },
                      child: Text("MARK AS SHIPPED"),

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 5.0,
                          color: Colors.black,
                        ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        widget.array[widget.index]['Type'] == "Flight"
                            ? getData("PrivateCharter", "Flight", "Denied")
                            : widget.array[widget.index]['Type'] == "Car"
                                ? getData("CarRental", "Car", "Denied")
                                : widget.array[widget.index]['Type'] ==
                                        "Repost"
                                    ? getData(
                                        "RepostRequests", "Repost", "Denied")
                                    : getData(
                                        "LuxuryGoods", "Goods", "Denied");
                      },
                      child: Text("MARK AS DENIED"),

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 5.0,
                          color: Colors.black,
                        ),
                        primary: Color(0xFFEB5B44),
                        onPrimary: Colors.black,
                        textStyle: TextStyle(
                          fontFamily: "Bizmo2",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 26,
                        ),
                        fixedSize: Size(320, 67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
