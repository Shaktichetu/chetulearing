import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/cart.dart';
import 'package:learn_getx/controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  final storage = GetStorage();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () {
              return Text("Email Address :${homeController.email.value}");
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                if (GetUtils.isEmail(emailController.text)) {
                  storage.write('email', emailController.text);
                  emailController.text = "";
                } else {
                  Get.snackbar("Incorrect email", "Provide valid id",
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child:const Text("Submit")),
          ElevatedButton(
              onPressed: () {
                homeController.updateEmail('${storage.read('email')}');
              },
              child:const Text("View")),
          GetBuilder<HomeController>(
              id: "follower_widget",
              builder: (_) {
                print("followers widget rebuilds");
                return Text("user followers: ${homeController.followers}");
              }),

          GetX<HomeController>(builder: (_) {
            print("status widget rebiulds");
            return Text("user Status: ${homeController.status}");
          }),
          Obx(() {
            print("status widget rebiulds with obx");
            return Text("user Status: ${homeController.status}");
          }),
          ElevatedButton(
              onPressed: () {
                homeController.updateStatus("offline");
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
