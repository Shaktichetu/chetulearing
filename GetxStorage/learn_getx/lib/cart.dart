import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(Get.arguments),
        ElevatedButton(
            onPressed: () {
              Get.back(result: "success");
            },
            child: Text("Going back"))
      ]),
    );
  }
}
