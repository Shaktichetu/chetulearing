import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_architech/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sharedpref/constants/preferences.dart';
import '../theme_colors.dart';
import 'event_name_screen.dart';

/* Created by Chetu
* this class used for show splash screen for few second
* */

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _currentPosition = 0.0;
  int count = 0;
  late Timer _timer;
  int _start = 4;

  @override
  void initState() {
    super.initState();

    // mehtod is used for start the time for splash
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/launcher_icon.png'),
              onPressed: () {},
              iconSize: 180,
            ),
            DotsIndicator(
              dotsCount: 6,
              position: _currentPosition,
              reversed: false,
              decorator: const DotsDecorator(
                color: Colors.black87, // Inactive color
                activeColor: ThemeColors.appThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // method is used for navigate the screen from splash to login
  navigate() async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
    // getting token
    var accessToken = preferences.getString(Preferences.auth_token);
    var userId = preferences.getString(Preferences.userId);

    if (accessToken != null) {

      // navigate to Event Name Screen
      Get.off(EventNameScreen(userId: int.parse(userId!)));
    } else {
      // navigate to Login screen Screen
      Get.off(LoginScreen());
    }
  }

  // methd is used for start the timer and after that it will be login screen or event screen
  startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();

            navigate();
          });
        } else {
          setState(() {
            _start--;
            _currentPosition += 1.0;
          });
        }
      },
    );
  }
}
