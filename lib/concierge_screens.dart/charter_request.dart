import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/widgets/textfield.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/concierge_screens.dart/Submitted.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';

class CharterRequest extends StatefulWidget {
  const CharterRequest({Key? key}) : super(key: key);

  @override
  _CharterRequestState createState() => _CharterRequestState();
}

class _CharterRequestState extends State<CharterRequest> {
  TextEditingController Departure_code = TextEditingController();
  TextEditingController Arrival_code = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController Number_passengers = TextEditingController();
  bool showSpinner = false;

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    var _doc = await FirebaseFirestore.instance
        .collection("PrivateCharter")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    // print(docStatus);
    if (docStatus == false) {
      FirebaseFirestore.instance
          .collection('PrivateCharter')
          .doc(UserDetails.uid)
          .set({
        'Flight': FieldValue.arrayUnion([
          {
            'Type': "Flight",
            'UserName': UserDetails.name,
            'Status': "Pending",
            'UID': UserDetails.uid,
            'DepartureCode': Departure_code.text,
            'ArrivalCode': Arrival_code.text,
            'Date': date.text,
            'time': time.text,
            'Passengers': Number_passengers.text,
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
              "Private Charter Added",
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
          .collection('PrivateCharter')
          .doc(UserDetails.uid)
          .update({
        'Flight': FieldValue.arrayUnion([
          {
            'Type': "Flight",
            'UserName': UserDetails.name,
            'Status': "Pending",
            'UID': UserDetails.uid,
            'DepartureCode': Departure_code.text,
            'ArrivalCode': Arrival_code.text,
            'Date': date.text,
            'time': time.text,
            'Passengers': Number_passengers.text,
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
              "Private Charter Added",
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

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var _date, d12;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black.withOpacity(.7),
              onPrimary: screen_color,
              surface: Colors.grey,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = DateTime.fromMicrosecondsSinceEpoch(
            selectedDate.microsecondsSinceEpoch);

        date.text = DateFormat('MM/dd/yyyy').format(_date); // 12/31/2000,
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black.withOpacity(.7),
              onPrimary: screen_color,
              surface: screen_color,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedTime = picked;

        final now = new DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, selectedTime.hour,
            selectedTime.minute);
        final format = DateFormat.jm(); //"6:00 AM"
        time.text = format.format(dt);
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
                  Text("PRIVATE\nCHARTER", style: myStyle(55, "Bizmo")),
                  Container(
                    child: Text(
                        "Start your Concierge Request by filling out the form below.",
                        style: myStyle(
                          15,
                          "Bizmo2",
                        )),
                  ),
                  SizedBox(height: 30),
                  Text("Departure Airport Code",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfieldSmall(hint_text: 'LAX', controller: Departure_code),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Arrival Airport Code",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfieldSmall(hint_text: 'NYC', controller: Arrival_code),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Date & Time",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () async {
                            _selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border:
                                  Border.all(color: Colors.black, width: 5.0),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                date.text,
                                style:
                                    myStyle(20, "Bizmo", color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () async {
                            _selectTime(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border:
                                  Border.all(color: Colors.black, width: 5.0),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                time.text,
                                style:
                                    myStyle(20, "Bizmo", color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Number of Passengers",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfieldNumber(
                      hint_text: '10', controller: Number_passengers),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () async {
                        if (Departure_code.text == null ||
                            Departure_code.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Departure Code",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (Arrival_code.text == null ||
                            Arrival_code.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Arrival Code",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (date.text == null || date.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Date",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (time.text == null || time.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Time",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (Number_passengers.text == null ||
                            Number_passengers.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Number of Passengers",
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
