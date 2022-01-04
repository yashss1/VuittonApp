import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/textfield.dart';
import 'package:vuitton_club/concierge_screens.dart/Submitted.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class LuxGoodRequest extends StatefulWidget {
  const LuxGoodRequest({Key? key}) : super(key: key);

  @override
  _LuxGoodRequestState createState() => _LuxGoodRequestState();
}

class _LuxGoodRequestState extends State<LuxGoodRequest> {
  TextEditingController name = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController budget = TextEditingController();

  bool showSpinner = false;

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    var _doc = await FirebaseFirestore.instance
        .collection("LuxuryGoods")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    // print(docStatus);
    if (docStatus == false) {
      FirebaseFirestore.instance
          .collection('LuxuryGoods')
          .doc(UserDetails.uid)
          .set({
        'Goods': FieldValue.arrayUnion([
          {
            'Type': "Goods",
            'Status': "Pending",
            'ItemName': name.text,
            'UserName': UserDetails.name,
            'Link': link.text,
            'Size': size.text,
            'UID': UserDetails.uid,
            'Budget': budget.text,
            'createdAt': Timestamp.now(),
          }
        ])
      }).then((value) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Luxury Goods Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Submitted(),
          ),
        );
      });
    } else {
      FirebaseFirestore.instance
          .collection('LuxuryGoods')
          .doc(UserDetails.uid)
          .update({
        'Goods': FieldValue.arrayUnion([
          {
            'Type': "Goods",
            'ItemName': name.text,
            'UserName': UserDetails.name,
            'Status': "Pending",
            'UID': UserDetails.uid,
            'Link': link.text,
            'Size': size.text,
            'Budget': budget.text,
            'createdAt': Timestamp.now(),
          }
        ])
      }).then((value) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Luxury Goods Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Submitted(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: top_margin, left: 22, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 50,
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  Text("LUXURY\nGOODS", style: myStyle(55, "Bizmo")),
                  Container(
                    child: Text(
                        "Start your Concierge Request by filling out the form below.",
                        style: myStyle(
                          15,
                          "Bizmo2",
                        )),
                  ),
                  SizedBox(height: 30),
                  Text("Name of Item",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: 'John Doe', controller: name),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Item Link (if any)",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(
                      hint_text: 'stockx.com',
                      controller: link..text = "None"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Size",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(
                      hint_text: 'Medium / US 9 / XS', controller: size),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Budget (in Dollars)",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfieldNumber(hint_text: '10,000', controller: budget),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () async {
                        if (name.text == null || name.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Name",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (link.text == null ||
                            link.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Link",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (size.text == null ||
                            size.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Size",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (budget.text == null ||
                            budget.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter your Budget",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          addIntoFirebase();
                        }
                      },
                      child: Text("SUBMIT"),
                      // ignore: prefer_const_constructors
                      
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
