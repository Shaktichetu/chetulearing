import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:project_architech/screen/forgot_password.dart';
import 'dart:convert';

import '../common/strings.dart';
import '../common/utility.dart';
import '../controllers/login_controller.dart';
import '../network/user_api_provider.dart';
import '../response/login_response.dart';

/* Created by Chetu
*  login screen called after the splash screen
 */
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  // put the controller and find the editcontroller for text edit
  LoginController loginController = Get.put(LoginController());
  TextEditingController login = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Box? box;
  Box? boxLoginData;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

      _passwordVisible = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                          child: IconButton(
                        icon: Image.asset('assets/images/launcher_icon.png'),
                        onPressed: () {},
                        iconSize: 200,
                      )),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.enter_email_id;
                            }

                            return null;
                          },
                          controller: login,
                          decoration: InputDecoration(
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
                            hintText: Strings.enter_email_cap,
                            hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.enter_password;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText:  !_passwordVisible,
                        controller: password,
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
                            prefixIcon:
                                Icon(Icons.lock_rounded, color: Colors.black),
                            hintText: Strings.enter_password_cap,
                            hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: 14),
                            suffixIcon:
                        IconButton(onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                            icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black87,
                        ),
                        )),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.to(ForgotPassword());
                                },
                                child: Text(
                                  Strings.forgot_password,
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
                                  UserApiProvider()
                                      .isConnected()
                                      .then((internet) async {
                                        // check internet available or not
                                    if (internet) {


                                      if (_formKey.currentState!.validate()) {
                                        loginController.login(
                                            login.text, password.text,
                                            loginResponse: []).then((value) {});
                                      } else {}
                                    } else {
                                      LoginResponse response = await getData();

                                      print(md5
                                          .convert(utf8.encode(
                                          password.text.toString()))
                                          .toString()
                                          .toUpperCase());
                              print('getBox Data');
                                      print(box?.get(Strings.userName));
                                      // method is used to call login API
                                      if (md5
                                                  .convert(utf8.encode(
                                                      password.text.toString()))
                                                  .toString()
                                                  .toUpperCase() ==
                                              box?.get(Strings.password) &&
                                          md5
                                                  .convert(utf8.encode(
                                                      login.text.toString()))
                                                  .toString()
                                                  .toUpperCase() ==
                                              box?.get(Strings.userName)) {



                                        if (_formKey.currentState!.validate()) {
                                          loginController
                                              .login(login.text, password.text,
                                                  loginResponse: response)
                                              .then((value) {});
                                        }
                                      } else {
                                        Utility.showToast(
                                            Strings.userpasswordwrong);
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  Strings.login,
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
  // method is used for get the data locally
  Future<LoginResponse> getData() async {
    final  posts =
        await Hive.box(Strings.API_BOX).get(Strings.posts, defaultValue: []);
    return LoginResponse.fromJson(posts);

  }


}
