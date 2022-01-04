import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/Services/user_details.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/widgets/textfield.dart';
import 'package:vuitton_club/contants.dart';

class RepostRequest extends StatefulWidget {
  const RepostRequest({Key? key}) : super(key: key);

  @override
  _RepostRequestState createState() => _RepostRequestState();
}

class _RepostRequestState extends State<RepostRequest> {
  TextEditingController name = TextEditingController();
  TextEditingController link = TextEditingController();

  bool showSpinner = false;

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    var _doc = await FirebaseFirestore.instance
        .collection("RepostRequests")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    // print(docStatus);
    if (docStatus == false) {
      FirebaseFirestore.instance
          .collection('RepostRequests')
          .doc(UserDetails.uid)
          .set({
        'Repost': FieldValue.arrayUnion([
          {
            'Type': "Repost",
            'UserName': UserDetails.name,
            'UID': UserDetails.uid,
            'Status': "Pending",
            'InstaHandle': name.text,
            'URL': link.text,
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
              "Repost Request Sent",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pop(context);
      });
    } else {
      FirebaseFirestore.instance
          .collection('RepostRequests')
          .doc(UserDetails.uid)
          .update({
        'Repost': FieldValue.arrayUnion([
          {
            'Type': "Repost",
            'UID': UserDetails.uid,
            'UserName': UserDetails.name,
            'Status': "Pending",
            'InstaHandle': name.text,
            'URL': link.text,
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
              "Repost Request Sent",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pop(context);
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
                  Text("REPOST\nREQUEST", style: myStyle(55, "Bizmo")),
                  Container(
                    child: Text(
                        "Enter the information below and we\nwill get back to you ASAP!",
                        style: myStyle(
                          15,
                          "Bizmo2",
                        )),
                  ),
                  SizedBox(height: 30),
                  Text("Instagram @",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(hint_text: 'thevuittonclub', controller: name),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Post URL",
                      style: myStyle(17, "Bizmo2", fw: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  textfield(
                      hint_text: 'https://instagram.com/..', controller: link),
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
                                "Please Enter your Instagram Handle",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (link.text == null || link.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter the Link",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else if (Uri.parse(link.text).isAbsolute == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter a valid URL",
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
                    height: 40,
                  ),
                  Text(
                      "*Please note, due to the club’s social posting guidelines, some requests may be denied.",
                      style: myStyle(
                        13,
                        "Bizmo2",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "If you are denied, we will reach out directly to you via DM explaining why.",
                      style: myStyle(
                        13,
                        "Bizmo2",
                      )),
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
