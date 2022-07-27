import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/strings.dart';
import '../controllers/reset_controller.dart';

/* Created by Chetu */

class ResetScreen extends StatefulWidget {

  // make global variable for email
  String? email;

  ResetScreen({Key? key, this.email}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  // init globle form key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // find the controller of otp resetController
  ResetController resetController = Get.put(ResetController());

  // init text edit controller for newpassword
  TextEditingController newpassword = TextEditingController(text: '');
  // init text edit controller for newpassword_Confirm
  TextEditingController newpassword_Confirm = TextEditingController(text: '');

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
              child: Padding(
                padding: const EdgeInsets.all(38.0),
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
                            SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return Strings.please_enter_password;
                                }
                                return null;
                              },
                              controller: newpassword,
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
                                    Icons.password,
                                    color: Colors.black,
                                  ),
                                  hintText: Strings.please_enter_password,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500)),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return Strings.please_enter_confirm_password;
                                }
                                return null;
                              },

                              controller: newpassword_Confirm,
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
                                    Icons.password,
                                    color: Colors.black,
                                  ),
                                  hintText:
                                      Strings.please_enter_confirm_password,
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

                                  // method is used for call reset API
                                  if (formKey.currentState!.validate()) {
                                    resetController.reset(
                                        widget.email,
                                        newpassword.text,
                                        newpassword_Confirm.text);
                                  }

                                },
                                child: Text(
                                  Strings.confirm,
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
