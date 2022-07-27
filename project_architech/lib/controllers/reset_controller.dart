import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/reset_password_response.dart';
import '../screen/login_screen.dart';


class ResetController extends GetxController{

  Future<ResetPasswordResponse?> reset(String? email,String password,String repassword) async{
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        await userRepository.resetApi(email!,password,repassword).then((value) async {
          if (value!.code == 200) {
            EasyLoading.dismiss();
            Utility.showToast(value.message.toString());
            Get.offAll(LoginScreen());
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