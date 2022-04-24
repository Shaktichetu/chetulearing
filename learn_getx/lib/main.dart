import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/cart.dart';
import 'package:learn_getx/controller.dart';
import 'package:learn_getx/homebinding.dart';
import 'package:learn_getx/shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
     // initialBinding: HomeBinding(),
      getPages: [
        GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding())
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //  home: HomePage(),
      initialRoute: '/home',
    );
  }
}

class HomePage extends GetWidget<HomeController> {
  //HomePage({Key? key}) : super(key: key);
  //HomeController homeController = Get.put(HomeController(), permanent: true);
 // HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<HomeController>(
              id: "follower_widget",
              builder: (_) {
                print("followers widget rebuilds");
                return Text("user followers: ${controller.followers}");
              }),

          GetX<HomeController>(builder: (_) {
            print("status widget rebiulds");
            return Text("user Status: ${controller.status}");
          }),
          Obx(() {
            print("status widget rebiulds with obx");
            return Text("user Status: ${controller.status}");
          }),
          ElevatedButton(
              onPressed: () {
                Get.to(Shop());
                controller.updateStatus("offline");
              },
              child: Text("Logout"))
          // ElevatedButton(
          //     onPressed: () {
          //       Get.to(Cart(), arguments: "Hello flutter");
          //     },
          //     child: Text("Navigate"))
        ],
      ),
    );
  }
}
