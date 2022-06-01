import 'package:get/get.dart';

class HomeController extends GetxController {
  var status = "online".obs;
  var followers = 50.obs;
  var email = ''.obs;

  void updateEmail(newEmail){
      email.value = newEmail;
  } 

  @override
  void onInit() {
    // ever(status, (_) {
    //   print("status value changed");
    // });
    // everAll([status, followers], (_) {
    //   print("status or followers value changed");
    // });
    // once(status, (_) {
    //   print("status changes once in a function");
    // });
    debounce(status, (_) {
      print("debounce status");
    },time: Duration(seconds: 1));
    super.onInit();
  }

  void updateStatus(newStatus) {
    status.value = newStatus;
    //update(["status_widget"]);
  }
}
