import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/otp_response.dart';
import '../screen/reset_screen.dart';



class OtpController extends GetxController {
  Future<OTPResponse?> otp(String? email,String otp) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        await userRepository.otpApi(email!,otp).then((value) async {
          if (value!.code == 200) {
            EasyLoading.dismiss();
            Utility.showToast(value.message.toString());
           // Utility.showToast(Strings.otp_send);
            Get.to(ResetScreen(email: email));
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
