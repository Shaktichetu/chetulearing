import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/strings.dart';
import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/login_response.dart';
import '../screen/event_name_screen.dart';
import '../sharedpref/constants/preferences.dart';


/*
* created by Chetu
* class is used for login state here we can use store user name and password for secure login
* */
class LoginController extends GetxController {

  // box are use for store data
  Box? box;

  @override
  void onInit() {
    super.onInit();


  }


  // method are use for login purpose
  Future<LoginResponse?> login(String userName, String password,
      {loginResponse}) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();

      // mehtod are check here for the internet connection
      if (internet) {
        getWithInternet(userRepository, userName, password);
      } else {

        // method are call when internet are not avilable
        getWithOutInternet(userName, password, loginResponse!);
      }
    });
  }



  // mehtod are call when internet are available
  void getWithInternet(
      UserRepository userRepository, String userName, String password) async {
    await userRepository.loginAPI(userName, password).then((value) async {
      if (value!.code == 200) {

        // method is used for save user name and password and call event screen
        saveUserName(userName, password, value);
        return value;
      } else {}
      Utility.showToast(value.message.toString());
    });
  }

  // mehtod are call when internet are not available
  Future<LoginResponse?> getWithOutInternet(
      String userName, String password, LoginResponse value) async {
    if (value.code == 200) {

      // method is used for save user name and password
      saveUserName(userName, password, value);
      return value;
    } else {}
  }

  saveUserName(String userName, String password, LoginResponse value) async {


    EasyLoading.dismiss();
    Utility.showToast(value.message!.toString());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Preferences.auth_token, value.data!.token.toString());
    preferences.setString(Preferences.userId, value.data!.userId.toString());
    box?.put(Strings.userName,
        md5.convert(utf8.encode(userName)).toString().toUpperCase());
    box?.put(Strings.password,
        md5.convert(utf8.encode(password)).toString().toUpperCase());
     print("CHECKGETDATA $userName + $password");
    print(box?.get(Strings.userName));

    Get.to(EventNameScreen(
      userId: value.data!.userId,
    ));
  }




}
