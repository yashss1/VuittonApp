import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Networking/rolodex_individual.dart';
import 'package:vuitton_club/contants.dart';

class Rolodex extends StatefulWidget {
  const Rolodex({Key? key}) : super(key: key);

  @override
  _RolodexState createState() => _RolodexState();
}

class _RolodexState extends State<Rolodex> {
  TextEditingController search = TextEditingController();
  String searchField = "";

  bool resultData(List arr, int index, String _key) {
    String email = arr[index]['Info']['Email'];
    String name = arr[index]['Info']['Name'];
    String phone = arr[index]['Info']['PhoneNumber'];
    String handle = arr[index]['Info']['InstaId'];
    email = email.toLowerCase();
    name = name.toLowerCase();
    phone = phone.toLowerCase();
    handle = handle.toLowerCase();
    _key = _key.toLowerCase();
    // print(
    // "Email -> ${email} : Name -> ${name} : Phone -> ${phone} : Handle -> ${handle}");
    if (email.contains(_key) ||
        name.contains(_key) ||
        phone.contains(_key) ||
        handle.contains(_key)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                  Text("CLUB\nROLODEX", style: myStyle(55, "Bizmo")),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                autofocus: false,
                                onChanged: (text) {
                                  setState(() {
                                    searchField = text;
                                    // print(searchField);
                                  });
                                },
                                controller: search,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.text,
                                style: myStyle(20, "Bizmo", color: Colors.grey),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search Members',
                                  hintStyle:
                                      myStyle(20, "Bizmo", color: Colors.grey),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                    "You can search by:",
                    style: TextStyle(fontFamily: "Bizmo2"),
                  )),
                  Center(
                      child: Text(
                    " Name, Email, Phone, or Handle",
                    style: TextStyle(fontFamily: "Bizmo2"),
                  )),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .snapshots(),
                        builder: (ctx, AsyncSnapshot snaps) {
                          if (snaps.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final _snap = snaps.data!.docs;
                          return _snap.length == 0
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height * .3,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "WE'RE SORRY",
                                        style: myStyle(40, 'Bizmo'),
                                      ),
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
                                  itemCount: _snap.length,
                                  itemBuilder: (context, index) {
                                    return (resultData(
                                                _snap, index, searchField)) ==
                                            false
                                        ? SizedBox(height: 0)
                                        : Column(
                                            children: [
                                              item(
                                                s1: _snap[index]['Info']
                                                    ['Name'],
                                                s2: _snap[index]['DataShared']
                                                            ['Location'] ==
                                                        false
                                                    ? "Worldwide"
                                                    : _snap[index]['Info']
                                                        ['Location'],
                                                ontap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RolodexIndividual(
                                                                array: _snap,
                                                                index: index,
                                                              )));
                                                },
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          );
                                  },
                                );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
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
        child: Stack(
          children: [
            Padding(
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.play_arrow_outlined,
                size: 50,
              ),
            ),
          ],
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
