import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/avilable_barrier_list_response.dart';

class AvilableBarrierListController extends GetxController {

  RxList<BarrierCodeList> avilableBarrierListController = <BarrierCodeList>[]
      .obs;

  @override
  void onInit() {
    super.onInit();
  }

  // method is used for get barrier list which are shown in to the barrier list screen
  Future<AvilableBarrierListResponse?> getBarrierList(int userId, String activityId) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        await userRepository.getBarrierList(userId, activityId).then((
            value) async {

          avilableBarrierListController.value = value!.barrierCodeList!;
          EasyLoading.dismiss();

          update();
        });
      } else {
        EasyLoading.dismiss();
        // Utility.showLoader("internet not working");
      }
      update();
    });
  }


}