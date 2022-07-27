import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';

import '../common/strings.dart';
import '../common/utility.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/dashboard_response.dart';


class DashboardController extends GetxController {

  Rx<DashboardResponse> dashboardResponse = DashboardResponse().obs;
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // method is used for get activity count
  Future<DashboardResponse?> getActivity(String? userId,int? idEvent) async {
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();

      if (internet) {
        await userRepository.activityApi(userId!,idEvent!).then((value) async {

          print(value);

            if(value!.code ==200){
               isLoading = false;

            // dashboardResponse.value.data= value.data!;
              // dashboardResponse.value.data!.totalUpdated = value.data!.totalUpdated;
              // dashboardResponse.value.data!.incompleteActivity = value.data!.incompleteActivity;
            setDashboardValue(value);
            update();

          } else {
            Utility.showToast(Strings.something_wrong);
          }
          EasyLoading.dismiss();
          update();
        });
      } else {

        // method is used when user goes offline them getData() method is callend and get the data from local storage
        DashboardResponse response = await getData();
        setDashboardValue(response);
        return response;
      }
    });
    update();
  }

  Future<DashboardResponse> getData() async {
    final  dashboardResponse =
    await Hive.box(Strings.dashboard_data_local).get(Strings.dashboard_data_local, defaultValue: []);
    return DashboardResponse.fromJson(dashboardResponse);

  }

  void setDashboardValue(DashboardResponse? value) {

       dashboardResponse.value.data= value!.data!;

    // dashboardResponse.value.data!.totalActivity = value!.data!.totalActivity;
    // dashboardResponse.value.data!.totalUpdated = value.data!.totalUpdated;
    // dashboardResponse.value.data!.incompleteActivity = value.data!.incompleteActivity;

    update();
    EasyLoading.dismiss();
  }}
