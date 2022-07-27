import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project_architech/controllers/progress_update_controller.dart';

import '../network/user_api_provider.dart';
import '../network/user_repository.dart';

class UpdateTaskActivityController extends GetxController {
  RxBool isSave = false.obs;
  ProgressUpdateController progressUpdateController =
      Get.put(ProgressUpdateController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<dynamic> updateTask(BuildContext context,String id, int activityInPercentComplete,
      String actualStartDate, String? actualFinishDate) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        EasyLoading.dismiss();

        await userRepository
            .updateTask(id, activityInPercentComplete, actualStartDate,
                actualFinishDate)
            .then((value) async {
          isSave.value = value;
          print(isSave.value);
          // Navigator.of(context).pop();

          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProgressUpdateScreen()));



          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Navigator.pop(context);
                // ProgressUpdateScreen()
                     )).then((value) {
            print('update progress calll======');
          });*/
          // Get.back();
          //Get.off(ProgressUpdateScreen());
          // Utility.showToast(value.toString());
          update();

          return value;
        });
      } else {
        EasyLoading.dismiss();
        // Utility.showLoader("internet not working");
      }
      update();
    });
  }
}
