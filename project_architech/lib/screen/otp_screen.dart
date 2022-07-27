import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../common/strings.dart';
import '../controllers/otp_controller.dart';

/* Created by Chetu */

class OTPScreen extends StatefulWidget {

  // make global variable for email
  String? email;

  OTPScreen({Key? key, this.email}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  // init globle form key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // find the controller of otp controller
  OtpController otpController = Get.put(OtpController());

  // init text edit controller for otp
  TextEditingController otp = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              // margin: EdgeInsets.symmetric(vertical: 100),
              child: Padding(
                padding: const EdgeInsets.all(58.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                          child: IconButton(
                        icon: Image.asset('assets/images/logo_tactexs.png'),
                        onPressed: () {},
                        iconSize: 200,
                      )),

                      Container(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                Strings.email_id_to +" "+ Strings.reset_password,
                                style: TextStyle(
                                    color: Color(0xffaf0947),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                              ),
                            ),
                           /* Text(
                              Strings.reset_password,
                              style: TextStyle(
                                  color: Color(0xffaf0947),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),*/
                            SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return Strings.please_enter_otp;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              controller: otp,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: Colors.black87, width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: Colors.black87, width: 2.0)),
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Colors.black,
                                  ),
                                  hintText: Strings.enter_otp_here,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 28),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.0),
                                    primary: Color(0xffaf0947)),
                                onPressed: () {
                                  // method is used for call OTP API

                                  if (formKey.currentState!.validate()) {
                                    otpController.otp(widget.email, otp.text);
                                  }
                                },
                                child: Text(
                                  Strings.validate_otp,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
