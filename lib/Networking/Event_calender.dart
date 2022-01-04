import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Admin_Panel/add_event.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/contants.dart';

class EventCalender2 extends StatefulWidget {
  const EventCalender2({Key? key}) : super(key: key);

  @override
  _EventCalender2State createState() => _EventCalender2State();
}

class _EventCalender2State extends State<EventCalender2> {
  var array, arr;

  Future getData() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Events').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        arr = data['Events'];
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Container(
                    // color: screen_color,
                    margin: EdgeInsets.only(top: top_margin, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              size: 50,
                            ),
                          ),
                        ),
                        Text("EVENTS", style: myStyle(55, "Bizmo")),
                        SizedBox(
                          height: 20,
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

                              return (array == null || array.length == 0)
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .height *
                                            .3,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "WE'RE SORRY",
                                            style: myStyle(40, 'Bizmo'),
                                          ),
                                          Center(
                                            child: Text(
                                              "There is Nothing here, Please Check Again Later...",
                                              textAlign: TextAlign.center,
                                              style: myStyle(20, 'Bizmo'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: array.length == null
                                          ? 0
                                          : array.length,
                                      itemBuilder: (context, index) {
                                        // print(array[index]);
                                        return Column(
                                          children: [
                                            SizedBox(height: 10),
                                            items(
                                                s1:
                                                    "${array[index]['EventName']}",
                                                s2:
                                                    "${array[index]['Location']}",
                                                date:
                                                    "${array[index]['Date']}",
                                                month:
                                                    "${array[index]['Month']}"),
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
                ),
              ),
            ],
          ),
        ));
  }
}

class items extends StatelessWidget {
  final String s1, s2, date, month;

  const items(
      {Key? key,
      required this.s1,
      required this.s2,
      required this.date,
      required this.month})
      : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  s1,
                  style: myStyle(22, 'Bizmo'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  s2,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Bizmo2',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              Container(
                height: 60,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Text(month, style: myStyle(18, "Bizmo")),
                      Text(
                        date,
                        style: myStyle(32, "Bizmo"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
