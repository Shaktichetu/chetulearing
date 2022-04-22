import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/controllers/post_controllers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

 class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<PostsController>(
        init: PostsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title:const Text('Posts'),
            ),
            body: controller.loading.value
                ? const Center(child: CircularProgressIndicator())
                : Text(controller.transactionModel.toString() ),
            floatingActionButton: FloatingActionButton(
              child:const Icon(Icons.add),
              onPressed: () {
                controller.getPosts();
              },
            ),
          );
        });
  }
}