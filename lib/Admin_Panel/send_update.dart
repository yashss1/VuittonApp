import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Admin_Panel/Goods.dart';
import 'package:vuitton_club/Admin_Panel/cars.dart';
import 'package:vuitton_club/Admin_Panel/flights.dart';
import 'package:vuitton_club/Admin_Panel/repost.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

import 'Home_Admin.dart';

class SendUpdate extends StatefulWidget {
  const SendUpdate({Key? key, required this.array, required this.index})
      : super(key: key);

  final array, index;

  @override
  _SendUpdateState createState() => _SendUpdateState();
}

class _SendUpdateState extends State<SendUpdate> {
  TextEditingController message = TextEditingController();

  bool showSpinner = false;
  var temp;
  var temp2 = [];

  Future getData() async {
    // CarRental - Car
    // PrivateCharter - Flight
    // LuxuryGoods - Goods

    setState(() {
      showSpinner = true;
    });
    String collectionType = widget.array[widget.index]['Type'] == 'Car'
        ? "CarRental"
        : widget.array[widget.index]['Type'] == 'Flight'
            ? "PrivateCharter"
            : widget.array[widget.index]['Type'] == 'Repost'
                ? "RepostRequests"
                : "LuxuryGoods";
    String type = widget.array[widget.index]['Type'];
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection(collectionType).get();
    final List<DocumentSnapshot> documents = result.docs;
    // Iterate through all the Documents
    documents.forEach((data) {
      // Iterating
      if (data.id == widget.array[widget.index]['UID']) {
        temp = data[type];

        // Deleting the Document
        FirebaseFirestore.instance
            .collection(collectionType)
            .doc(data.id)
            .delete();

        // Finding the Particular requests in all the arrays of documents
        for (var i = 0; i < temp.length; i++) {
          if (temp[i]['createdAt'] == widget.array[widget.index]['createdAt']) {
            //Extracting the Updates Array
            if (temp[i]['Update'] != null) temp2 = temp[i]['Update'];
          }
        }

        // Adding the Message
        Map<String, dynamic> mp = {
          'Message': message.text,
          'Date': Timestamp.now(),
          'AddedBy': UserDetails.name,
        };
        temp2.add(mp);
        if (temp2 != null) {
          //Sorting
          temp2.sort(
            (a, b) {
              return a['Date'].toString().toLowerCase().compareTo(
                    b['Date'].toString().toLowerCase(),
                  );
            },
          );
        }

        // Adding the Updated Updates array back in the Array of Type
        for (var i = 0; i < temp.length; i++) {
          if (temp[i]['createdAt'] == widget.array[widget.index]['createdAt']) {
            //Extracting the Updates Array
            temp[i]['Update'] = temp2;
          }
        }

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
                "Updates Added",
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
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: button_color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Send",
                                  style: myStyle(20, 'Bizmo'),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15,
                                      bottom: 11,
                                      top: 11,
                                      right: 15),
                                  fillColor: Color(0xFFF3EFD8),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF3EFD8), width: 5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF3EFD8), width: 5.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  hintText: 'Type the message to send...',
                                  hintStyle: myStyle(
                                    15,
                                    "Bizmo2",
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                style:
                                    myStyle(20, "Bizmo2", color: Colors.grey),
                                controller: message,
                              ),
                            ]),
                      )),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () async {
                        if (message.text == null ||
                            message.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Update",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          getData();
                        }
                      },
                      // => Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Home())),
                      child: Text("SEND UPDATE"),

                      // ignore: prefer_const_constructors
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
