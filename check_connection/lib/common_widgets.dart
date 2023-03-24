
import 'package:get/get.dart';

class CommonWidgets{

static Future<void> showInternetDialog(message) {
    return Get.defaultDialog(
        middleText: message,
        barrierDismissible: false,
        onWillPop: () => Future.value(false));
  }

}