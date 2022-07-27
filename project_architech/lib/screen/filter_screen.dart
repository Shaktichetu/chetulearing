/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tactexs/common/strings.dart';
import 'package:tactexs/common/utility.dart';
import 'package:tactexs/controllers/filter_list_controller.dart';
import 'package:tactexs/controllers/progress_update_controller.dart';
import 'package:tactexs/screen/progress_update_screen.dart';
import 'package:tactexs/sharedpref/constants/preferences.dart';
import 'package:tactexs/theme_colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/progress_update_model.dart';
*/
/* Created by Chetu *//*


class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterListController filterListController = Get.put(FilterListController());
  ProgressUpdateModel? _progressUpdateModel;
  String? userId;
  ProgressUpdateController progressUpdateController =
  Get.put(ProgressUpdateController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressUpdateModel = Utility.getProgressUpdateModel();
    getUserId();


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ThemeColors.appThemeColor,
          title: Text(
            Strings.filter_selection,
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    Strings.daterange,
                    style: TextStyle(
                        color: ThemeColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: (){

                      // navigate to progress update screen
                      Get.off(ProgressUpdateScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: ThemeColors.appThemeColor,border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              Strings.twelve_hrs,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                            ),
                          ),),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: (){

                      // navigate to progress update screen
                      Get.off(ProgressUpdateScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: ThemeColors.appThemeColor,border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              Strings.twenty_four,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: (){
                     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>ProgressUpdateScreen()), (route) => false);
                      Get.off(ProgressUpdateScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: ThemeColors.appThemeColor,border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              Strings.thirty_hrs,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: (){

                       filterListController.filterList(context,_progressUpdateModel!.getidEvent!,userId!,"ToatalActivity","","2022-03-17T13:00:00",
                           "2022-03-17T19:46:00").then((value) {

                       });
                      // navigate to progress update screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: ThemeColors.appThemeColor,border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              Strings.custom,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // method is used for get user id from shared preferences
  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(Preferences.userId);

    // method is used for get the list of progress
  }}
*/
