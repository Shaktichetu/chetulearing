import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';

class BarrierAddUpdateController extends GetxController {

  RxBool isUpdate = false.obs;
  RxBool isUpdateBarrierCode = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  //method is used for add barrier code into the barrier list
  Future<dynamic> addUpdateBarrierCoe(String activityId,int userId,String barrierCode,String delayTime,String barrierDescription,
      String wbscode,String timeStamp,bool isDelete,bool isEditable) async{
      UserApiProvider().isConnected().then((internet) async {
        UserRepository userRepository = UserRepository();
        EasyLoading.show();
        if (internet) {
          EasyLoading.dismiss();

          await userRepository.addUpdateBarrier(activityId,userId,barrierCode,delayTime,barrierDescription,wbscode,
              timeStamp, isDelete,isEditable).then((value) async {

              isUpdate.value = value;
              print(isUpdate.value);

            //Utility.showToast(value.toString());
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

  //method is used for update barrier list
  Future<dynamic> UpdateBarrierCode(int? barrierCodeId,String activityId,int userId,String barrierCode,String delayTime,String barrierDescription,
      String wbscode,String timeStamp,bool isDelete,bool isEditable) async{
      UserApiProvider().isConnected().then((internet) async {
        UserRepository userRepository = UserRepository();
        EasyLoading.show();
        if (internet) {
          EasyLoading.dismiss();

          await userRepository.UpdateBarrier(barrierCodeId!,activityId,userId,barrierCode,delayTime,barrierDescription,wbscode,
              timeStamp, isDelete,isEditable).then((value) async {

            isUpdateBarrierCode.value = value;

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