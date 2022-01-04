import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Admin_Panel/Home_Admin.dart';
import 'package:vuitton_club/Admin_Panel/individual_info.dart';
import 'package:vuitton_club/contants.dart';

class Reposts extends StatefulWidget {
  const Reposts({Key? key}) : super(key: key);

  @override
  _RepostsState createState() => _RepostsState();
}

class _RepostsState extends State<Reposts> {
  var array, arr;

  Future getData() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('RepostRequests').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        arr = data['Repost'];
        if (array == null) {
          array = arr;
        } else {
          array += arr;
        }
      }
      print(array);
      // print(array.length);
      // print(array);
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
                Text("REPOSTS", style: myStyle(55, "Bizmo")),
                SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Individualnfo())),
                //   child: block()),
                //     SizedBox(height: 10,),
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
                                        array[index]['InstaHandle'],
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

  Container block(String status, String name, String handle) {
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
              "Repost Request",
              style: myStyle(20, 'Bizmo'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Status: ${status}",
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
              s1: "IG @: ",
              s2: "${handle}",
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
