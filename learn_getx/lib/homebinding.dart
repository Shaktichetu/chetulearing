import 'package:get/get.dart';
import 'package:learn_getx/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
  //  Get.put<HomeController>(HomeController(), permanent: true);
    Get.lazyPut(() => HomeController(),fenix:true);
  }
}
