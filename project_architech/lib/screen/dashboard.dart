import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_architech/screen/progress_update_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../common/strings.dart';
import '../common/utility.dart';
import '../controllers/dashboard_controller.dart';
import '../model/progress_update_model.dart';
import '../sharedpref/constants/preferences.dart';
import '../theme_colors.dart';

/* Created by Chetu */

class DashBoardScreen extends StatefulWidget {
  // make globle variable for id event
  int? idEvent;

  DashBoardScreen({Key? key, this.idEvent}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String? userId;
  String? dataDate;

  // put controller for dashboard
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // method is used for get user id from shared preferences
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        try {
          DateTime dt = DateTime.parse(dashboardController
              .dashboardResponse.value.data!.dataDate
              .toString());
          // startDateEvent = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
          dataDate = DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(dt); //2022-06-03 07:00:00
          print("startDateEvent");
          print(dataDate);
          // textEditingController = TextEditingController(text: startDateEvent);
          //   endDateEditingController = TextEditingController(text: EndDateEvent);
        } catch (Exception) {}

        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.appThemeColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.dashboard,
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Utility.showLoaderLogout(
                        "Are You Sure You want to Logout ?");
                  },
                  child: Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  // controller.dashboardResponse.value.data!.totalActivity != null
                  controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              Strings.dashboard,
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.dashboardResponse.value.data!
                                        .totalActivity ==
                                    0) {
                                  Utility.showToast("No Activities Found");

                                }else{
                                  Utility.setProgressUpdateModel(
                                      ProgressUpdateModel(
                                        idEvent: widget.idEvent,
                                        statusActivity: Strings.total_activity,
                                      ));

                                  Get.to(ProgressUpdateScreen());
                                }

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ThemeColors.appThemeColor,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Strings.total_activities,
                                            style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          controller.dashboardResponse.value
                                                      .data!.totalActivity !=
                                                  null
                                              ? Text(
                                                  controller.dashboardResponse
                                                      .value.data!.totalActivity
                                                      .toString(),
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  Strings.zero,
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                // call progress update screen here
                                if(controller.dashboardResponse.value
                                    .data!.totalUpdated == 0 ){
                                  Utility.showToast("No Activities Found");


                                }else{
                                  Utility.setProgressUpdateModel(
                                      ProgressUpdateModel(
                                        idEvent: widget.idEvent,
                                        statusActivity: Strings.complete,
                                      ));

                                  Get.to(ProgressUpdateScreen());
                                }

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ThemeColors.appThemeColor,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Strings.total_activities_updated,
                                            style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          controller.dashboardResponse.value
                                                      .data!.totalUpdated !=
                                                  null
                                              ? Text(
                                                  controller.dashboardResponse
                                                      .value.data!.totalUpdated
                                                      .toString(),
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  Strings.zero,
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelSmall,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                if(controller.dashboardResponse.value.data!
                                    .incompleteActivity == 0 ){
                                  Utility.showToast("No Activities Found");
                                }else{
                                  Utility.setProgressUpdateModel(
                                      ProgressUpdateModel(
                                        idEvent: widget.idEvent,
                                        statusActivity: Strings.incomplete,
                                      ));
                                  Get.to(ProgressUpdateScreen());

                                /*  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProgressUpdateScreen()));*/
                                }
                                // call the progress update screen here


                                // Get.to(ProgressUpdateScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.appThemeColor,
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Strings.total_activities_updated_less,
                                          style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        controller.dashboardResponse.value.data!
                                                    .incompleteActivity !=
                                                null
                                            ? Text(
                                                controller
                                                    .dashboardResponse
                                                    .value
                                                    .data!
                                                    .incompleteActivity
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                Strings.zero,
                                                style: GoogleFonts.lato(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: double.infinity,
                          /*    decoration: BoxDecoration(
                                    color: ThemeColors.appThemeColor,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(18.0)),*/
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Data Date:  ",
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.blackColor),
                                ),
                                Text(
                                  dataDate != null ? dataDate! : "N/A",
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.appThemeColor),
                                )
                                /* : Text(
                                   "N/A",

                                   style: GoogleFonts.lato(textStyle:Theme.of(context).textTheme.labelSmall,
                                       fontSize: 14,fontWeight: FontWeight.bold,color: ThemeColors.appThemeColor),),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(Preferences.userId);
    // method is used for call  get activity list
    dashboardController.getActivity(userId, widget.idEvent);
  }
}
