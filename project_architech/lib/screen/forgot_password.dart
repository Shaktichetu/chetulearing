import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_architech/screen/login_screen.dart';

import '../common/strings.dart';
import '../controllers/forgot_controller.dart';

/* Created by Chetu */

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  // find the controller of forgot controller
  ForgotController forgotController = Get.put(ForgotController());

  // init text edit controller for email
  TextEditingController email = TextEditingController(text: '');

  // init globle form key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(38.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
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
                            Text(
                              Strings.forgot_password,
                              style: TextStyle(
                                  color: Color(0xffaf0947),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.please_enter_email_id;
                          }
                          return null;
                        },
                        controller: email,
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
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "ENTER YOUR EMAIL ID",
                            hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: 14)),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.off(LoginScreen());
                                },
                                child: Text(
                                  Strings.click_login,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                )),
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

                                  // method is used for call forgot API
                                  if (formKey.currentState!.validate()) {
                                    forgotController.forgot(email.text);
                                  }

                                  // Get.to(CheckEmailScreen());
                                },
                                child: Text(
                                  Strings.send_email,
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
