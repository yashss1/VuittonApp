import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuitton_club/Home/home.dart';
import 'package:vuitton_club/contants.dart';

class MoreInfoCar extends StatefulWidget {
  const MoreInfoCar({Key? key, required this.array, required this.index})
      : super(key: key);

  final array, index;

  @override
  _MoreInfoCarState createState() => _MoreInfoCarState();
}

class _MoreInfoCarState extends State<MoreInfoCar> {
  var arr, date, d12;

  @override
  void initState() {
    super.initState();
    arr = widget.array[widget.index]['Update'];
    // print(arr);
    // date = widget.array[widget.index]['createdAt'].toDate;
    date = DateTime.fromMicrosecondsSinceEpoch(
        widget.array[widget.index]['createdAt'].microsecondsSinceEpoch);

    // 12 Hour format:
    d12 = DateFormat('MM/dd/yyyy').format(date); // 12/31/2000, 10:00 PM
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen_color,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
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
                            MaterialPageRoute(builder: (context) => Home()),
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
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Car Request",
                              style: myStyle(24, 'Bizmo'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Car Preference : ${widget.array[widget.index]['CarPreference']}\nBudget: ${widget.array[widget.index]['Budget']}\nDate: ${widget.array[widget.index]['Date']}\nLocation : ${widget.array[widget.index]['Location']}\n",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Bizmo2',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "STATUS: ${widget.array[widget.index]['Status']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Bizmo2',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    )),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: button_color,
                        border: Border.all(
                          color: Colors.black,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Updates",
                                style: myStyle(24, 'Bizmo'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "THEVUITTONCLUB - ${d12}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Bizmo2',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Thank you. Your concierge request has been sent..",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Bizmo2',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              // List of Updates
                              Expanded(
                                child: (arr == null || arr.length == 0)
                                    ? Container()
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: arr.length,
                                        itemBuilder: (context, index) {
                                          // print(array[index]);
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${arr[index]['AddedBy']} - ${DateFormat('MM/dd/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(arr[index]['Date'].microsecondsSinceEpoch))}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Bizmo2',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "${arr[index]['Message']}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Bizmo2',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ]),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
