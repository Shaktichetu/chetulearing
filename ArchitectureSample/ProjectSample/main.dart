import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constants/app_colors.dart';
import 'constants/font_path.dart';
import 'constants/routes.dart';
import 'constants/strings.dart';
import 'languages/locales.dart';
import 'languages/multilanguage.dart';
import 'utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        fontFamily: FontPath.primaryFont,
        primarySwatch: AppColors.customPrimarySwatch,
      ),
      translations: Multilanguage(),
      locale: Locales.getLocale(language: Preferences.getMultiLanguage()),
      fallbackLocale: Locales.getLocale(language: Strings.english),
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
    );
  }
}
