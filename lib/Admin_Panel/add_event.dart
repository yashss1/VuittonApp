import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Admin_Panel/event_calender.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/widgets/textfield.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/contants.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController event_name = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController location = TextEditingController();

  bool showSpinner = false;

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });
    var _doc = await FirebaseFirestore.instance
        .collection("Events")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    // print(docStatus);
    if (docStatus == false) {
      FirebaseFirestore.instance.collection('Events').doc(UserDetails.uid).set({
        'Events': FieldValue.arrayUnion([
          {
            'Type': "Event",
            'UserName': UserDetails.name,
            'EventName': event_name.text,
            'Location': location.text,
            'Month': month.text,
            'Date': date.text,
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
              "Event Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeAdmin(),
          ),
        );
      });
    } else {
      FirebaseFirestore.instance
          .collection('Events')
          .doc(UserDetails.uid)
          .update({
        'Events': FieldValue.arrayUnion([
          {
            'Type': "Event",
            'UserName': UserDetails.name,
            'EventName': event_name.text,
            'Location': location.text,
            'Month': month.text,
            'Date': date.text,
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
              "Event Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeAdmin(),
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
                  Text("ADD\nEVENT", style: myStyle(55, "Bizmo")),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Event Name",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: 'Yacht Party', controller: event_name),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Location",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: 'Ibiza, Spain', controller: location),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Date",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: '21', controller: date),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Month",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: 'APR', controller: month),
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (event_name.text == null ||
                            event_name.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter an Event",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (location.text == null ||
                            location.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Location",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (date.text == null ||
                            date.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Date",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (month.text == null ||
                            month.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Month",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          addIntoFirebase();
                        }
                      },
                      child: Text("ADD EVENT"),

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 5.0,
                          color: Colors.black,
                        ),
                        primary: Color(0xFF95DB74),
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
