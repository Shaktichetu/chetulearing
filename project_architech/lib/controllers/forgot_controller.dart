import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common/strings.dart';
import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/forgot_response.dart';
import '../screen/otp_screen.dart';



class ForgotController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // method is used for forgot the email
  Future<ForgotResponse?> forgot(String email) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        await userRepository.forgotApi(email).then((value) async {
          if (value!.code == 200) {
            EasyLoading.dismiss();
            Utility.showToast(Strings.otp_send);
            Get.to(OTPScreen(email: email));
            return value;
          } else {
            EasyLoading.dismiss();
          }
          Utility.showToast(value.message.toString());
        });
      } else {
        EasyLoading.dismiss();
        // Utility.showLoader("internet not working");
      }
    });
  }
}
