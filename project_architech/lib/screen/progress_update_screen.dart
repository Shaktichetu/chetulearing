import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../common/strings.dart';
import '../common/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/progress_update_controller.dart';
import '../controllers/update_task_activity_controller.dart';
import '../model/progress_update_model.dart';
import '../response/filter_list_response.dart';
import '../response/group_by_response.dart';
import '../theme_colors.dart';
/* Created by Chetu */

class ProgressUpdateScreen extends StatefulWidget {
  // make global variable for id event and for status activity
  int? idEvent;
  String? statusActivity;

  ProgressUpdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgressUpdateScreen> createState() => _ProgressUpdateScreenState();
}

class _ProgressUpdateScreenState extends State<ProgressUpdateScreen> {
  String? userId;
  ProgressUpdateModel? _progressUpdateModel;
  ProgressUpdateController progressUpdateController =
      Get.put(ProgressUpdateController());
  List<ProgressUpdateList?> newProductList = [];
  String? dataDate;

  // List<ProgressUpdateList?> areaList = [];
  List areaList = [];
  List<ProgressUpdateList?> wbsCodeList = [];
  List<ProgressUpdateList?> equipmentList = [];
  List<ProgressUpdateList> newListWithSort = [];
  TextEditingController startDateEvent = TextEditingController(text: '');
  TextEditingController EndDateEvent = TextEditingController(text: '');
  bool isDismiss = true;
  var isVisible = false;
  UpdateTaskActivityController updateTaskActivityController =
      Get.put(UpdateTaskActivityController());
  DashboardController dashboardController = Get.put(DashboardController());

  String? btnCustom;
  String? startDateEventDate;
  String? endDateEventDate;

  // String? startDateEvent;
  // String? EndDateEvent;

  bool isCustom = true;
  bool isUpDown = false;
  bool isSort = false;

  bool expandableListView = false;

  @override
  void initState() {
    // TODO: implement initState

    /*  try {
        DateTime dtEndDate = DateTime.parse(widget.endDate.toString());
        print("EndDateEvent");

        EndDateEvent = DateFormat(Strings.dateformat_).format(dtEndDate);
        print(EndDateEvent);
        setEndEventDate(EndDateEvent!,true);
        // textEditingController = TextEditingController(text: startDateEvent);
        //   endDateEditingController = TextEditingController(text: EndDateEvent);
      } catch (error , stacktrace) {
        print("Exception occured EndDate: $error stackTrace: $stacktrace");

      }*/
    super.initState();
    isDismiss = true;
    isVisible = false;
    isCustom = true;
    isUpDown = false;
    isSort = false;

    btnCustom = Strings.custom;
    // get the progress update model data into _progressUpdateModel
    _progressUpdateModel = Utility.getProgressUpdateModel();

    // method is used for get user id from shared preferences
    getUserId();
    getGroupByList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.progress_update,
                style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  Utility.showLoaderLogout("Are You Sure You want to Logout ?");
                },
                child: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Get.to(FilterScreen());
            showModalBottomSheet<void>(
              context: context,
              isDismissible: isDismiss,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeColors.blackColor, width: 1)),
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(CupertinoIcons.clear_thick)),
                          ),
                          Center(
                            child: Text(
                              Strings.filter_selection,
                              style: TextStyle(
                                  color: ThemeColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const Text(
                            Strings.daterange,
                            style: TextStyle(
                                color: ThemeColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          InkWell(
                            onTap: () {
                              // navigate to progress update screen
                              callFilterList(12);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ThemeColors.appThemeColor,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(18.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    Strings.twelve_hrs,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              // navigate to progress update screen
                              callFilterList(24);
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      Strings.twenty_four,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>ProgressUpdateScreen()), (route) => false);
                              callFilterList(36);
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      Strings.thirty_hrs,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Visibility(
                            visible: isCustom,
                            child: InkWell(
                              onTap: () {
                                showLoader();
                                // Get.back();
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
                                      child: Text(
                                        "Custom",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            // getUserId();
            //  _offsetPopup();
          },
          label: InkWell(
            child: Container(
                child: Column(
              children: [
                Text(Strings.filter),
              ],
            )),
          ),
          icon: Icon(CupertinoIcons.slider_horizontal_3),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //isUpDown == false
                            //    ?
                            isSort
                                ? InkWell(
                                    onTap: () {
                                      sortListUsingActivityID(isSort);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.sort_up,
                                          size: 18,
                                        ),
                                        Text(
                                          Strings.sort_by,
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                                : InkWell(
                                    onTap: () {
                                      sortListUsingActivityID(isSort);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.sort_down,
                                          size: 18,
                                        ),
                                        Text(
                                          Strings.sort_by,
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 2.0,
                            ),
                            InkWell(
                              onTap: () {
                                if (progressUpdateController
                                    .groupListName!.value.isEmpty) {
                                  Utility.showToast("No Data found");
                                } else {
                                  _showPopupMenu();
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    Strings.group_by,
                                    style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    CupertinoIcons.arrowtriangle_down_fill,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              //callAreaFilteredList("55272236");
                              //var newMap = groupBy(progressUpdateController.progressUpdateresponse, (Map obj) => obj['area']);
                              for (int i = 0;
                                  progressUpdateController
                                          .progressUpdateresponse.length >
                                      i;
                                  i++) {
                                newProductList.add(progressUpdateController
                                    .progressUpdateresponse[i]);
                              }

                              // if("area" == "area") {
                              for (int i = 0; newProductList.length > i; i++) {
                                if (newProductList[i]!.area != null) {
                                  // areaList.add(newProductList[i]);
                                  print("areaList");
                                  print(newProductList.length);
                                  print(newProductList);
                                  break;
                                }
                              }

                              for (int i = 0; newProductList.length > i; i++) {
                                if (newProductList[i]!.wbscode != null) {
                                  // wbsCodeList.add(newProductList[i]);
                                  print("wbsCodeList");
                                  print(wbsCodeList.toString());
                                  break;
                                }
                              }
                              for (int i = 0; newProductList.length > i; i++) {
                                if (newProductList[i]!.equipmentNumber !=
                                    null) {
                                  equipmentList.add(newProductList[i]);

                                  print("equipmentList");
                                  print(equipmentList.toString());
                                  break;
                                }
                              }

                              // }

                              //  var newMap = groupBy([], (Map obj) => obj['release_date']);
                            },
                            child: Text(
                              Strings.area,
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.headlineSmall,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          /*  const SizedBox(
                            width: 12,
                          ),*/
                          /*const VerticalDivider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),*/
                          Text(
                            Strings.activity_code,
                            style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          /* const SizedBox(
                            width: 6,
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),*/
                          Text(
                            Strings.equipment_id,
                            style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          /* const VerticalDivider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),*/
                          Text(
                            Strings.activity_desc,
                            style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                    expandableListView == false
                        ?
                        /*
                    if (newListWithSort.isNotEmpty)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: newListWithSort.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          print("newListWithSort.length" + newListWithSort.length.toString());
                          if(progressUpdateController.areaCheckedValue.value == true && newListWithSort[index].area.toString() == "UT/CH") {
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          newListWithSort[index].area.toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          newListWithSort[index]
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              newListWithSort[index]
                                                  .equipmentNumber !=
                                                  null
                                                  ? newListWithSort[index]
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            newListWithSort[index]
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if(progressUpdateController.wbsCheckedValue.value == true){
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          newListWithSort[index].area.toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          newListWithSort[index]
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              newListWithSort[index]
                                                  .equipmentNumber !=
                                                  null
                                                  ? newListWithSort[index]
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            newListWithSort[index]
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }else if(progressUpdateController.equipCheckedValue.value == true) {
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          newListWithSort[index].area.toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          newListWithSort[index]
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              newListWithSort[index]
                                                  .equipmentNumber !=
                                                  null
                                                  ? newListWithSort[index]
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            newListWithSort[index]
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }

                        },
                      )
                    else if (progressUpdateController
                            .progressUpdateresponse.length >
                        0)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: progressUpdateController
                            .progressUpdateresponse.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          if(progressUpdateController.areaCheckedValue.value == true || progressUpdateController.progressUpdateresponse[index]!.area == null) {
                            print("Area"+progressUpdateController
                                .progressUpdateresponse.length.toString());
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!.area
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber !=
                                                  null
                                                  ? progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            progressUpdateController
                                                .progressUpdateresponse[index]!
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if(progressUpdateController.wbsCheckedValue.value == true && progressUpdateController.progressUpdateresponse[index]!.wbscode == "55272236"){
                            print("WBC"+progressUpdateController
                                .progressUpdateresponse.length.toString());
                            print(progressUpdateController
                                .progressUpdateresponse[index]!.wbscode.toString());
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!.area
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber !=
                                                  null
                                                  ? progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            progressUpdateController
                                                .progressUpdateresponse[index]!
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }else if(progressUpdateController.equipCheckedValue.value == true && progressUpdateController.progressUpdateresponse[index]!.equipmentNumber != null) {
                            print("Equi"+progressUpdateController
                                .progressUpdateresponse.length.toString());
                            print(progressUpdateController.areaCheckedValue.value);
                            print(progressUpdateController
                                .progressUpdateresponse[index]!.area.toString());
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!.area
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber !=
                                                  null
                                                  ? progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            progressUpdateController
                                                .progressUpdateresponse[index]!
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            print("++++"+progressUpdateController
                                .progressUpdateresponse.length.toString());
                            return InkWell(
                              onLongPress: () {
                                getProgress(progressUpdateController, index);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!.area
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Text(
                                          progressUpdateController
                                              .progressUpdateresponse[index]!
                                              .activityCode
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber !=
                                                  null
                                                  ? progressUpdateController
                                                  .progressUpdateresponse[
                                              index]!
                                                  .equipmentNumber
                                                  .toString()
                                                  : Strings.na,
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            progressUpdateController
                                                .progressUpdateresponse[index]!
                                                .activityDescription
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                        },
                      )
                    else
                      Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Text(
                            Strings.no_record_found,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    */
                        newListWithSort.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: newListWithSort.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onLongPress: () {
                                      getProgress(
                                          progressUpdateController, index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 40.0,
                                                child: Text(
                                                  newListWithSort[index].area !=
                                                          null
                                                      ? newListWithSort[index]
                                                          .area
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              /*  const VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1.0,
                                              ),*/
                                              // SizedBox(width: 14.0,),
                                              SizedBox(
                                                width: 85.0,
                                                child: Text(
                                                  newListWithSort[index]
                                                              .activityCode !=
                                                          null
                                                      ? newListWithSort[index]
                                                          .activityCode
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),

                                              SizedBox(
                                                width: 100.0,
                                                child: Text(
                                                  newListWithSort[index]
                                                              .equipmentNumber !=
                                                          null
                                                      ? newListWithSort[index]
                                                          .equipmentNumber
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 110.0,
                                                child: Text(
                                                  newListWithSort[index]
                                                              .activityDescription !=
                                                          null
                                                      ? newListWithSort[index]
                                                          .activityDescription
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : progressUpdateController
                                        .progressUpdateresponse.length >
                                    0
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: progressUpdateController
                                        .groupProgressUpdateResponse.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = progressUpdateController
                                          .groupProgressUpdateResponse[index];
                                      return Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (direction) {
                                          setState(() {


                                            try {
                                              DateTime dt = DateTime.parse(
                                                  progressUpdateController
                                                      .progressUpdateresponse[
                                                          index]!
                                                      .actualStartDate
                                                      .toString());
                                              // startDateEvent = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
                                              startDateEventDate = DateFormat(
                                                      Strings.dateformat_)
                                                  .format(dt);
                                              print("startDateEvent");
                                              print(startDateEventDate);
                                              //setStartEventDate(startDateEvent!);
                                              // textEditingController = TextEditingController(text: startDateEvent);
                                              //   endDateEditingController = TextEditingController(text: EndDateEvent);
                                            } catch (error, stacktrace) {
                                              print(
                                                  "Exception occured StartDate: $error stackTrace: $stacktrace");
                                            }
                                            try {
                                              DateTime dt = DateTime.parse(
                                                  DateTime.now().toString());
                                              // startDateEvent = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
                                              endDateEventDate = DateFormat(
                                                      Strings.dateformat_)
                                                  .format(dt);
                                              print("EndDateEventDate");
                                              print(endDateEventDate);
                                              //setStartEventDate(startDateEvent!);
                                              // textEditingController = TextEditingController(text: startDateEvent);
                                              //   endDateEditingController = TextEditingController(text: EndDateEvent);
                                            } catch (error, stacktrace) {
                                              print(
                                                  "Exception occured StartDate: $error stackTrace: $stacktrace");
                                            }
                                            try {
                                              DateTime dt = DateTime.parse(progressUpdateController
                                                  .progressUpdateresponse[index]!.dataDate
                                                  .toString());
                                              // startDateEvent = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
                                              dataDate =
                                                  DateFormat(Strings.dateformat_).format(dt); //2022-06-03 07:00:00
                                              print("startDateEvent");
                                              print(dataDate);
                                              // textEditingController = TextEditingController(text: startDateEvent);
                                              //   endDateEditingController = TextEditingController(text: EndDateEvent);
                                            } catch (Exception) {}
                                            print('yes its work');
                                            print(startDateEventDate);
                                            print(dataDate);
                                            if(startDateEventDate != null ){
                                              updateTaskActivityController
                                                  .updateTask(
                                                  context,
                                                  progressUpdateController
                                                      .groupProgressUpdateResponse[
                                                  index]!
                                                      .activityCode!,
                                                  100,
                                                  startDateEventDate!,
                                                  endDateEventDate!)
                                                  .then((value) {
                                                print(value);

                                                setState(() {

                                                });
                                                updateTaskActivityController
                                                    .progressUpdateController
                                                    .update();
                                                progressUpdateController
                                                    .groupProgressUpdateResponse.refresh();


                                                Future.delayed(
                                                    const Duration(milliseconds: 200), () {
                                                  //   getUserId();
                                                  dashboardController.getActivity(userId,
                                                      _progressUpdateModel!.getidEvent!);
                                                  //  getProgrssListAPICall(userId!);
                                                });
                                                Future.delayed(
                                                    Duration(microseconds: 300), () {
                                                  getUserId();

                                                });

                                              });
                                            }else if(dataDate !=null){
                                              updateTaskActivityController
                                                  .updateTask(
                                                  context,
                                                  progressUpdateController
                                                      .groupProgressUpdateResponse[
                                                  index]!
                                                      .activityCode!,
                                                  100,
                                                  dataDate!,
                                                  endDateEventDate!)
                                                  .then((value) {
                                                print(value);

                                                setState(() {

                                                });
                                                updateTaskActivityController
                                                    .progressUpdateController
                                                    .update();
                                                progressUpdateController
                                                    .groupProgressUpdateResponse.refresh();



                                                Future.delayed(
                                                    const Duration(milliseconds: 200), () {
                                                  //   getUserId();
                                                  dashboardController.getActivity(userId,
                                                      _progressUpdateModel!.getidEvent!);
                                                  //  getProgrssListAPICall(userId!);
                                                });


                                                Future.delayed(
                                                    Duration(microseconds: 300), () {
                                                  getUserId();

                                                });

                                              });
                                            }
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Update successfully')));
                                        },
                                        background: Container(
                                            color: ThemeColors.appThemeColor),
                                        child: InkWell(
                                          onLongPress: () {
                                            getProgress(
                                                progressUpdateController,
                                                index);
                                          },
                                          child:
                                          progressUpdateController
                                              .groupProgressUpdateResponse[
                                          index]!
                                              .currentPercentComplete ==100 ?
                                          Container(
                                              color: Colors.greenAccent.shade100,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0,vertical: 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.0,
                                                        child: Text(
                                                          progressUpdateController
                                                                      .groupProgressUpdateResponse[
                                                                          index]!
                                                                      .area !=
                                                                  null
                                                              ? progressUpdateController
                                                                  .groupProgressUpdateResponse[
                                                                      index]!
                                                                  .area
                                                                  .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 85.0,
                                                        child: Text(
                                                          progressUpdateController
                                                                      .groupProgressUpdateResponse[
                                                                          index]!
                                                                      .activityCode !=
                                                                  null
                                                              ? progressUpdateController
                                                                  .groupProgressUpdateResponse[
                                                                      index]!
                                                                  .activityCode
                                                                  .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100.0,
                                                        child: Text(
                                                          progressUpdateController
                                                                      .groupProgressUpdateResponse[
                                                                          index]!
                                                                      .equipmentNumber !=
                                                                  null
                                                              ? progressUpdateController
                                                                  .groupProgressUpdateResponse[
                                                                      index]!
                                                                  .equipmentNumber
                                                                  .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 110.0,
                                                        child: Text(
                                                          progressUpdateController
                                                                      .groupProgressUpdateResponse[
                                                                          index]!
                                                                      .activityDescription !=
                                                                  null
                                                              ? progressUpdateController
                                                                  .groupProgressUpdateResponse[
                                                                      index]!
                                                                  .activityDescription
                                                                  .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                    thickness: 1.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                              :
                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0,vertical: 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.0,
                                                        child: Text(
                                                          progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .area !=
                                                              null
                                                              ? progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .area
                                                              .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 85.0,
                                                        child: Text(
                                                          progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .activityCode !=
                                                              null
                                                              ? progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .activityCode
                                                              .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100.0,
                                                        child: Text(
                                                          progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .equipmentNumber !=
                                                              null
                                                              ? progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .equipmentNumber
                                                              .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 110.0,
                                                        child: Text(
                                                          progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .activityDescription !=
                                                              null
                                                              ? progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                          index]!
                                                              .activityDescription
                                                              .toString()
                                                              : Strings.na,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ),
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        Strings.no_record_found,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                        : ExpansionTile(
                            title: Text(
                              "Area",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: progressUpdateController
                                    .groupProgressUpdateResponse.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onLongPress: () {
                                      getProgress(
                                          progressUpdateController, index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 40.0,
                                                child: Text(
                                                  progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                                  index]!
                                                              .area !=
                                                          null
                                                      ? progressUpdateController
                                                          .groupProgressUpdateResponse[
                                                              index]!
                                                          .area
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              /*  const VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1.0,
                                              ),*/
                                              // SizedBox(width: 14.0,),
                                              SizedBox(
                                                width: 85.0,
                                                child: Text(
                                                  progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                                  index]!
                                                              .activityCode !=
                                                          null
                                                      ? progressUpdateController
                                                          .groupProgressUpdateResponse[
                                                              index]!
                                                          .activityCode
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),

                                              SizedBox(
                                                width: 100.0,
                                                child: Text(
                                                  progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                                  index]!
                                                              .equipmentNumber !=
                                                          null
                                                      ? progressUpdateController
                                                          .groupProgressUpdateResponse[
                                                              index]!
                                                          .equipmentNumber
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 110.0,
                                                child: Text(
                                                  progressUpdateController
                                                              .groupProgressUpdateResponse[
                                                                  index]!
                                                              .activityDescription !=
                                                          null
                                                      ? progressUpdateController
                                                          .groupProgressUpdateResponse[
                                                              index]!
                                                          .activityDescription
                                                          .toString()
                                                      : Strings.na,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(400, 120, 0, 0),
      items: getPopupItems(progressUpdateController.groupListName?.value),
      /*  items: [

        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.area,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Checkbox(
                  value: progressUpdateController.areaCheckedValue.value,
                  onChanged: (bool? value) {
                    progressUpdateController.areaCheckedValue.value = value!;
                    progressUpdateController.groupProgressUpdateResponse.clear();
                    if(value == true){
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      for(var item in progressUpdateController.progressUpdateresponse){
                        if(item!.area != null){
                          progressUpdateController.groupProgressUpdateResponse.add(item);
                        }
                      }
                    }else {
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      progressUpdateController.groupProgressUpdateResponse.addAll(progressUpdateController.progressUpdateresponse);
                    }
                    progressUpdateController.update();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "WBS Code",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // To o filter list on wbs code......
              Obx(
                () => Checkbox(
                  value: progressUpdateController.wbsCheckedValue.value,
                  // onChanged: (bool? value) => progressUpdateController.filterGroupBy(
                  //     areaFlag: progressUpdateController.areaCheckedValue.value,
                  //     wbsFlag: value!,
                  //     equipmentFlag: progressUpdateController.equipCheckedValue.value
                  // ),
                  onChanged: (bool? value) {
                    progressUpdateController.wbsCheckedValue.value = value!;
                    progressUpdateController.groupProgressUpdateResponse.clear();
                    if(value == true){
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      for(var item in progressUpdateController.progressUpdateresponse){
                        if(item!.wbscode != null){
                          progressUpdateController.groupProgressUpdateResponse.add(item);
                        }
                      }
                    }else {
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      progressUpdateController.groupProgressUpdateResponse.addAll(progressUpdateController.progressUpdateresponse);
                    }
                    progressUpdateController.update();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.equipment_id+" Id",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Checkbox(
                  value: progressUpdateController.equipCheckedValue.value,
                  // onChanged: (bool? value) => progressUpdateController.filterGroupBy(
                  //     areaFlag: progressUpdateController.areaCheckedValue.value,
                  //     wbsFlag: progressUpdateController.wbsCheckedValue.value,
                  //     equipmentFlag: value!
                  // ),
                  onChanged: (bool? value) {
                    progressUpdateController.equipCheckedValue.value = value!;
                    if(value == true){
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      for(var item in progressUpdateController.progressUpdateresponse){
                        print('equipmentNumber====');
                        print(item!.id!);
                        if(item.equipmentNumber != null){
                          progressUpdateController.groupProgressUpdateResponse.add(item);
                        }
                      }
                    }else {
                      progressUpdateController.groupProgressUpdateResponse.clear();
                      print('equipmentNumber====  else part');
                      // print();
                      progressUpdateController.groupProgressUpdateResponse.addAll(progressUpdateController.progressUpdateresponse);
                    }
                    progressUpdateController.update();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ],*/
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) print(value);
    });
  }

  List<PopupMenuItem> getPopupItems(List<Data>? groupByList) {
    List<PopupMenuItem> items = List.empty(growable: true);
    for (int k = 0; k < groupByList!.length; k++) {
      Data? groupByItem = groupByList[k];
      items.add(PopupMenuItem(
        value: k,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              groupByItem.displayColumn.toString(),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Checkbox(
                value: progressUpdateController.groupListName?.value[k].checked,
                onChanged: (bool? value) {
                  progressUpdateController.areaCheckedValue.value = value!;
                  if (value == true) {
                    setState(() {
                      expandableListView = true;
                    });
                    progressUpdateController.groupProgressUpdateResponse
                        .clear();
                    for (var item
                        in progressUpdateController.progressUpdateresponse) {
                      if (item!.equipmentNumber != null) {
                        progressUpdateController.groupProgressUpdateResponse
                            .add(item);
                        print(progressUpdateController
                            .groupProgressUpdateResponse);
                      }
                    }
                    /*progressUpdateController.groupByConditions
                        .add(groupByItem.progressUpdateColumnName.toString());*/
                    progressUpdateController.groupListName?.value[k].checked =
                        true;
                  } else {
                    progressUpdateController.groupProgressUpdateResponse
                        .clear();
                    progressUpdateController.groupProgressUpdateResponse.addAll(
                        progressUpdateController.progressUpdateresponse);
                    progressUpdateController.groupListName?.value[k].checked =
                        false;
                    setState(() {
                      expandableListView = false;
                    });
                  }
                  progressUpdateController.update();
                  Get.back();

                  /*else {
                    progressUpdateController.groupByConditions.remove(
                        groupByItem.progressUpdateColumnName.toString());
                    progressUpdateController.groupListName?.value[k].checked =
                        false;
                  }*/
                },
              ),
            ),
          ],
        ),
      ));
    }
    return items;
  }

  void showLoader() {
    Get.back();
    Get.dialog(
      Dialog(
        child: Container(
          height: Get.height * 0.4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(CupertinoIcons.clear_thick)),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            Strings.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Text(
                            " *",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          //   Icon(CupertinoIcons.asterisk_circle_fill,size: 12,color: Colors.red,),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,

                        /* child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              // dateMask: "d-MM-yyyy HH:mm:ss",
                              dateMask: Strings.dateMask_,
                              // initialValue: startDateEvent,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero),
                              onChanged: (val) {
                                setState(() {
                                  startDateEvent = val;
                                  DateTime dt = DateTime.parse(startDateEvent!);

                                  startDateEvent =
                                      DateFormat(Strings.dateformat_)
                                          .format(dt);
                                });
                              },
                              validator: (val) {
                                return null;
                              },
                              onSaved: (val) {}),
                        ),*/
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  /* validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return Strings
                                          .enter_percent_complete;
                                    }
                                    return null;
                                  },*/
                                  keyboardType: TextInputType.number,
                                  controller: startDateEvent,
                                  decoration: InputDecoration(
                                      hintText: "Enter start hour",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            Strings.finish,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Text(
                            " *",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          //Icon(CupertinoIcons.asterisk_circle_fill,size: 12,color: Colors.red,),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            /*child: DateTimePicker(
                                type: DateTimePickerType.dateTime,
                                dateMask: Strings.dateMask_,
                                // initialValue: EndDateEvent,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero),
                                onChanged: (val) {
                                  setState(() {
                                    EndDateEvent = val;
                                    DateTime dtEndDate =
                                        DateTime.parse(EndDateEvent!);
                                    EndDateEvent =
                                        DateFormat(Strings.dateformat_)
                                            .format(dtEndDate);
                                  });
                                  print(val);
                                },
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) {
                                  print(val);
                                }),*/
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(18.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    /* validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return Strings
                                            .enter_percent_complete;
                                      }
                                      return null;
                                    },*/
                                    keyboardType: TextInputType.number,
                                    controller: EndDateEvent,
                                    decoration: InputDecoration(
                                        hintText: "Enter end hour",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                )),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            // isVisible = false;
                            // isCustom= true;
                            // btnCustom = "Search";
                          });

                          callFilterListWithCustomSearch();
                          // navigate to progress update screen
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: ThemeColors.appThemeColor,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Search",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
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
        ),
      ),
    );
  }

  void getProgrssListAPICall(String userId) async {
    progressUpdateController.progressUpdate(
      userId,
      _progressUpdateModel!.getidEvent!,
      _progressUpdateModel!.getstatusActivity,
    );
  }

  // method is used for get user id from shared preferences
  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(Preferences.userId);

    // method is used for get the list of progress
    getProgrssListAPICall(userId!);
  }

  // method is used for call update progress screen after the long press of cell.
  void getProgress(ProgressUpdateController controller, int index) {
    //  getProgrssListAPICall(userId!);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpdateProgressScreen(
                id: controller.progressUpdateresponse[index]!.id,
                startDate: controller
                    .progressUpdateresponse[index]!.actualStartDate
                    .toString(),
                endDate: controller
                    .progressUpdateresponse[index]!.actualFinishDate
                    .toString(),
                activityCode:
                    controller.progressUpdateresponse[index]!.activityCode,
                currentPercentComplete: controller
                    .progressUpdateresponse[index]!.currentPercentComplete,
                activityDescription: controller
                    .progressUpdateresponse[index]!.activityDescription,
                wbscode: controller.progressUpdateresponse[index]!.wbscode,
                activityBarrierList: controller
                    .progressUpdateresponse[index]!.activityBarrierCount,
                dataDate: controller.progressUpdateresponse[index]!.dataDate)));
      });
    });
  }

  void callFilterListWithCustomSearch() {
    if (startDateEvent.text == null || startDateEvent.text == "") {
      Utility.showLoader(Strings.please_enter_actual_start_hour);

      // Utility.showToast("Please Enter Actual Start Date");
    } else if (EndDateEvent.text == null || EndDateEvent.text == "") {
      Utility.showLoader(Strings.please_enter_actual_finish_hour);
      // Utility.showToast("Please Enter Actual Finish Date");
    } else /*if (startDateEvent!.compareTo(EndDateEvent!) < 0) */ {
      newListWithSort.clear();

      progressUpdateController
          .filterList(
              context,
              _progressUpdateModel!.getidEvent!,
              userId!,
              _progressUpdateModel!.statusActivity!,
              0,
              startDateEvent.text,
              EndDateEvent.text)
          .then((value) {
        setState(() {
          startDateEvent.text = "";
          EndDateEvent.text = "";
          Get.back();
          isDismiss = true;
        });
      });

      // "2022-03-17T13:00:00"
      // "2022-03-17T19:46:00"

    } /*else {
      Utility.showLoader(Strings.start_should_be_greater);
    }*/
  }

  void callFilterList(int status) {
    newListWithSort.clear();
    progressUpdateController
        .filterList(context, _progressUpdateModel!.getidEvent!, userId!,
            _progressUpdateModel!.statusActivity!, status, "0", "0")
        .then((value) {
      setState(() {
        Get.back();
        isDismiss = true;
      });
    });
  }

  void sortListUsingActivityID(bool Sort) {
    print(Sort);
    if (Sort) {
      newListWithSort.clear();

      progressUpdateController.progressUpdateresponse.sort((a, b) {
        return a!.activityCode!
            .toLowerCase()
            .compareTo(b!.activityCode!.toLowerCase());
      });
      progressUpdateController.progressUpdateresponse.forEach((element) {
        newListWithSort.add(element!);
      });

      print(newListWithSort.toString());

      setState(() {
        isSort = false;
      });
    } else {
      print(Sort);
      newListWithSort.clear();
      progressUpdateController.progressUpdateresponse.sort((a, b) => b!
          .activityCode!
          .toLowerCase()
          .compareTo(a!.activityCode!.toLowerCase()));

      progressUpdateController.progressUpdateresponse.forEach((element) {
        newListWithSort.add(element!);
      });
      setState(() {
        isSort = true;
      });
    }
  }

  void getGroupByList() {
    progressUpdateController.getGroupByList();
  }
}
