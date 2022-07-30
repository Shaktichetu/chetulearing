import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/barrier_code_response.dart';

class BarrierCodeController extends GetxController {

  RxList<BarrierCode?> barrierListRespnse = <BarrierCode>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // method is used for get barrier code
  Future<BarrierCodeResponse? > getBarrierCode() async{
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {

        await userRepository.getBarrierCodeApi().then((value) async {
          EasyLoading.dismiss();

          barrierListRespnse.value = value!.barrierCode!;
          update();
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