import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:project_architech/network/user_repository.dart';
import '../common/strings.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/dashboard_response.dart';
import '../response/group_by_response.dart';
import '../response/progress_update_response.dart';

class ProgressUpdateController extends GetxController {

  RxList<ProgressUpdateList?> progressUpdateresponse =
      <ProgressUpdateList>[].obs;

  // To filter list group by   .............................
  RxList<ProgressUpdateList?> groupProgressUpdateResponse =
      <ProgressUpdateList>[].obs;

  // To filter list group by   .............................
  RxList<Data>? groupListName =
      <Data>[].obs;
  List<String?> groupByConditions = [];
  RxBool areaCheckedValue = false.obs;
  RxBool wbsCheckedValue = false.obs;
  RxBool equipCheckedValue = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<ProgressUpdateResponse?> progressUpdate(String userId, int eventId, String statusActivity) async {
    UserApiProvider().isConnected().then((internet) async {
      EasyLoading.show();
      if (internet) {
        var userRepository = UserRepository();
        await userRepository.progressUpdate(userId, eventId, statusActivity).then((value) async {
          setProgressUpdateData(value!);
          groupProgressUpdateResponse.assignAll(value.data!);
          return value;
        });
        update();
      } else {
        ProgressUpdateResponse response = await getData();
        setProgressUpdateData(response);
        return progressUpdateresponse;
      }
    });
  }
   getGroupByList() async {
    UserApiProvider().isConnected().then((internet) async {
      EasyLoading.show();
      if (internet) {
        var userRepository = UserRepository();
        GroupBySearch? a= await userRepository.groupByListAPI();
        groupListName?.value = (a?.data)!;
        update();
      }
      /* else {
        ProgressUpdateResponse response = await getData();
        setProgressUpdateData(response);
        return progressUpdateresponse;
      }*/
    });
  }


  void filterGroupBy({required bool areaFlag, required bool wbsFlag, required bool equipmentFlag}) {
    wbsCheckedValue.value = wbsFlag;
    areaCheckedValue.value = areaFlag;
    equipCheckedValue.value = equipmentFlag;
    groupProgressUpdateResponse.clear();
    for(var item in progressUpdateresponse){
      if(item!.area != null){
        groupProgressUpdateResponse.add(item);
      } else  if(item.wbscode != null){
        groupProgressUpdateResponse.add(item);
      } else  if(item.equipmentNumber != null){
        groupProgressUpdateResponse.add(item);
      } else {
        groupProgressUpdateResponse;
      }
    }
    update();
  }




  //method is used for update barrier list
  Future<ProgressUpdateResponse?> filterList(
      BuildContext context,
      int eventId,
      String userId,
      String activityStatus,
      int range,
      String startDate,
      String endDate) async {
    UserApiProvider().isConnected().then((internet) async {
      var userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        EasyLoading.dismiss();
        await userRepository
            .filterList(
            eventId, userId, activityStatus, range, startDate, endDate)
            .then((value) async {
         // Get.delete<ProgressUpdateController>();
          progressUpdateresponse.value = value!.data!;
          update();
        //Get.back();
        //   filterResponse.value = value!.progressUpdateList!;
        //   progressUpdateresponse.value = filterResponse.value;

          return value;
        });
      } else {
        EasyLoading.dismiss();
      }
      update();
    });
  }
  Future<ProgressUpdateResponse> getData() async {
    final progressResponse = await Hive.box(Strings.progress_data_local)
        .get(Strings.progress_data_local, defaultValue: []);
    return ProgressUpdateResponse.fromJson(progressResponse);
  }
  void setProgressUpdateData(ProgressUpdateResponse value) {
    Future.delayed(Duration(seconds: 0), () {
      progressUpdateresponse.value = value.data!;
      update();
      EasyLoading.dismiss();
    });
  }
  
  UserRepository() {}
}
