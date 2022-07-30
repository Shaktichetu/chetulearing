
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_architech/common/strings.dart';
import '../controllers/refreshtoken_controller.dart';
import '../model/progress_update_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/splash.dart';
import '../sharedpref/constants/preferences.dart';
class Utility {
  static ProgressUpdateModel? _progressUpdateModel;

  static setProgressUpdateModel(progressUpdateModel) {
    _progressUpdateModel = progressUpdateModel;
  }

  static getProgressUpdateModel() {
    return _progressUpdateModel;
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  // method is used for show loader this is common for all the screen
  static void showLoader(String msg) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                msg,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Text(
                Strings.ok,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
  static void showLoaderLogout(String msg) {
    Get.defaultDialog(
      barrierDismissible: true,
      title: '',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                msg,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async{
                    SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                    preferences.setString(Preferences.auth_token,
                        '');
                    // Get.back();
                    preferences.clear();
                    Get.offAll(SplashScreen());
                  },
                  child: Text(
                    Strings.yes,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    Strings.cancel,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }

  static void showLoaderForError(String msg) async{

    RefreshTokenController refreshTokenController =
        Get.put(RefreshTokenController());
    Get.defaultDialog(
      barrierDismissible: true,
      title: '',
      content: GetBuilder<RefreshTokenController>(
        init: RefreshTokenController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    msg,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                InkWell(
                  onTap: () async {

                   getRefreshToken();
                  /*  SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString(Preferences.auth_token,
                        '');
                   // Get.back();
                     preferences.clear();
                    Get.offAll(LoginScreen());
*/

                  },
                  child: Text(
                    Strings.ok,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  static void getRefreshToken() async{

    RefreshTokenController refreshTokenController =
    Get.put(RefreshTokenController());
   await refreshTokenController.getToken();

  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return Strings.enter_valid_email;
    else
      return "";
  }
}
