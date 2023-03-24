import 'dart:async';

import 'package:check_connection/string_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common_widgets.dart';
/*Created by : @Chetu
Date : Feb 28, 2023.
Description : Check internet available or not. */

class InternetCheckController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 1.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

//  bool isDialogOpen  = false;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        if (connectionType.value == 0) {
          Get.back();
        }
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        if (connectionType.value == 0) {
          Get.back();
        }
        connectionType.value = 2;
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        CommonWidgets.showInternetDialog(StringConstants.internetCheck);
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
