import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:vuitton_club/Onboarding/phone_verify.dart';
import 'package:vuitton_club/widgets/button_widget.dart';
import 'package:vuitton_club/contants.dart';
import 'package:vuitton_club/widgets/textfield.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  TextEditingController phone_number = TextEditingController();
  String dialCode = "+1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: screen_color,
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                "assets/images/lv logo 2.png",
                height: 325,
                width: 325,
              ),
              alignment: Alignment.topLeft,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 240, left: 22, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PHONE", style: myStyle(55, "Bizmo")),
                    Container(
                      child: Text("Enter your number to continue",
                          style: myStyle(
                            18,
                            "Bizmo2",
                          )),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 5),
                            ),
                            child: CountryCodePicker(
                              onChanged: (c) {
                                print(c.dialCode);
                                dialCode = c.dialCode!;
                              },
                              initialSelection: 'US',
                              favorite: ['+1', 'US'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              flagDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: textfieldNumber(
                                hint_text: '(555) 555-5555',
                                controller: phone_number),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: button(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneVerify(
                                      phone: "$dialCode${phone_number.text}",
                                    ))),
                        child: Text("CONTINUE"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
