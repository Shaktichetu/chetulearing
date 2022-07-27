import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';

class DeleteBarrierActivityController extends GetxController{
  dynamic isDelete = "".obs;


  @override
  void onInit() {
    super.onInit();
  }

// method is used for delete barrier activity using activity id.
  Future<dynamic> deleteBarrierActivity(String activityId) async{
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        EasyLoading.dismiss();

        await userRepository.deleteBarrierActivity(activityId).then((value) async {

          try{

            isDelete.value = value;
            Utility.showLoader(isDelete.value);
            print(isDelete.value);
          }catch(Exception){

          }

          update();
          return value;
        });
      } else {
        EasyLoading.dismiss();
      }
      update();

    });

  }

}