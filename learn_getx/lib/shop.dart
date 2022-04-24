import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/controller.dart';

class Shop extends StatelessWidget {
   Shop({ Key? key }) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 100),
        Obx((){
            print("status widget rebiulds with obx");
            return Text("user Status: ${homeController.status}");
          }),
      ],),
    );
  }
}