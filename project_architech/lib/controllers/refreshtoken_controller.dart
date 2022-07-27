import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project_architech/response/token_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../screen/splash.dart';
import '../sharedpref/constants/preferences.dart';



class RefreshTokenController extends GetxController {
  Rx<RefreshTokenResponse> refreshToken = RefreshTokenResponse().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Future<RefreshTokenResponse? > getToken() async{
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {

       // print('call refresh api');
        await userRepository.getToken().then((value) async {
          EasyLoading.dismiss();
          refreshToken.value = value!;
         // print(refreshToken.value);
        SharedPreferences preferences =
          await SharedPreferences.getInstance();
          preferences.setString(Preferences.auth_token,
              refreshToken.value.token!);
       //   print("REFRESHTOKEN=====getToken"+refreshToken.value.token!);

          update();
          Get.offAll(SplashScreen());
          //Utility.showToast(value.mailStatus.toString());
        });
      } else {
        EasyLoading.dismiss();
        // Utility.showLoader("internet not working");
      }
      update();

    });

  }

}