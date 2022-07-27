import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_architech/screen/splash.dart';
import 'package:project_architech/theme_helper.dart';
import 'common/hive_helper.dart';
import 'common/strings.dart';
// method is work for start the application
void main() async {
  // hive are initialized here for store the data
 // await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
   HiveHelper.openHive();
  runApp(const MyApp());
}


// this class is used for init the splash screen
class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: ThemeHelpers.atRedTypeColor,
      ),
      home: SplashScreen(),
    );
  }
}
