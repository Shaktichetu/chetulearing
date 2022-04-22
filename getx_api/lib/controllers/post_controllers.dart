import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../all_event_model.dart';
import '../api/posts_provider.dart';
import '../models/TransactionModel.dart';
import '../models/post_model.dart';

class PostsController extends GetxController {
  var posts = <SportingEventContracts>[].obs;
  var loading = false.obs;
  var transactionModel = TransactionModel().obs;
  PostsProvider _provider = PostsProvider();
  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    // checkIsLogin();
    // print("ww");
    super.onInit();
    getPosts();
  }

  getPosts() async {
    loading(true);
    var response = await _provider.getPosts();
    if (!response.status.hasError) {
      transactionModel.value =
          TransactionModel.fromJson(json.decode(response.toString()));
      print(transactionModel);
    }
    loading(false);
  }

  sendPost() async {
    loading(true);
    var response = await _provider.sendPost({
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    });
    if (!response.status.hasError) {
      Get.snackbar('Success', 'Post added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
    loading(false);
  }
}
