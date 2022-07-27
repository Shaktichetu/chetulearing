import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/strings.dart';
import '../common/utility.dart';
import '../controllers/avilable_barrier_list_controller.dart';
import '../controllers/barrier_add_update_controller.dart';
import '../controllers/barrier_code_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/delete_barrier_activity.dart';
import '../controllers/progress_update_controller.dart';
import '../model/progress_update_model.dart';
import '../response/barrier_code_response.dart';
import '../sharedpref/constants/preferences.dart';
import '../theme_colors.dart';

/* Created by Chetu */

class BarrierCodeAddUpdateScreen extends StatefulWidget {
  String? startDate;
  String? endDate;
  int? currentPercentComplete;
  String? activityCode;
  String? activityDescription;
  String? wbscode;
  int? activityBarrierList;

  BarrierCodeAddUpdateScreen(
      {Key? key,
      this.startDate,
      this.endDate,
      this.activityCode,
      this.currentPercentComplete,
      this.activityDescription,
      this.wbscode,
      this.activityBarrierList})
      : super(key: key);

  @override
  State<BarrierCodeAddUpdateScreen> createState() => _BarrierCodeScreenState();
}

class _BarrierCodeScreenState extends State<BarrierCodeAddUpdateScreen> {
  String? btnValue;
  ProgressUpdateModel? _progressUpdateModel;

  BarrierAddUpdateController barrierAddUpdateController =
      Get.put(BarrierAddUpdateController());
  DashboardController dashboardController = Get.put(DashboardController());
  ProgressUpdateController progressUpdateController =
      Get.put(ProgressUpdateController());

  DeleteBarrierActivityController deleteBarrierActivityController =
      Get.put(DeleteBarrierActivityController());

  AvilableBarrierListController avilableBarrierListController =
      Get.put(AvilableBarrierListController());
  BarrierCodeController barrierCodeController =
      Get.put(BarrierCodeController());
  String? userId;
  bool? isVisible;

  BarrierCode? _dropDownValue;
  TextEditingController description = TextEditingController();
  TextEditingController delayHrs = TextEditingController();

  int? barrierCodeId;
  String? activityCodeResponse;

  String? wbscodeResponse;

  String? timeStampResponse;

  int? userIdResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnValue = Strings.add;
    isVisible = false;
    getUserId();
    _progressUpdateModel = Utility.getProgressUpdateModel();

    barrierCodeController.getBarrierCode();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BarrierCodeController>(
      init: BarrierCodeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
            Strings.add_update,
          ),
                  InkWell(
                    onTap: (){
                      Utility.showLoaderLogout("Are You Sure You want to Logout ?");
                    },
                    child: Icon(
                      Icons.logout,
                    ),
                  ),
                ],
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          Strings.activity_code_with_comma,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          widget.activityCode!,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          Strings.description + ":",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            widget.activityDescription!,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Strings.barrier_code,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          controller.barrierListRespnse.length > 0
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  child: DropdownButton(
                                    underline: SizedBox(),
                                    hint: _dropDownValue == null
                                        ? Container(
                                            margin: EdgeInsets.fromLTRB(
                                                18, 0, 0, 0),
                                            child: Text(
                                                Strings.select_barrier_code))
                                        : Container(
                                            margin: EdgeInsets.fromLTRB(
                                                18, 0, 0, 0),
                                            child: Text(
                                              _dropDownValue!.shortCode! +
                                                  " - " +
                                                  _dropDownValue!.code!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            )),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: TextStyle(color: Colors.black),
                                    items: controller.barrierListRespnse.map(
                                      (e) {
                                        return DropdownMenuItem<BarrierCode>(
                                          value: e,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e!.shortCode! +
                                                        " - " +
                                                        e.code!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _dropDownValue = val as BarrierCode;
                                      });
                                    },
                                  ))
                              : Column(
                                  children: [
                                    Text(
                                      Strings.no_record_found,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.delay_hour,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Strings.add_delay_hours;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: delayHrs,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero)),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Strings.add_description;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  controller: description,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero)),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          InkWell(
                            onTap: () {
                              if (_dropDownValue == null) {
                                Utility.showLoader(
                                    Strings.please_enter_barrier_code);
                              } else if (delayHrs.text.isEmpty ||
                                  delayHrs.text == null) {
                                Utility.showLoader(
                                    Strings.please_enter_delay_code);
                              } else if (description.text.isEmpty ||
                                  description.text == null) {
                                Utility.showLoader(
                                    Strings.please_enter_description);
                              } else {
                                if (btnValue == Strings.add) {
                                  barrierAddUpdateController
                                      .addUpdateBarrierCoe(
                                          widget.activityCode.toString(),
                                          int.parse(userId!),
                                          _dropDownValue!.shortCode!,
                                          delayHrs.text,
                                          description.text,
                                          widget.wbscode.toString(),
                                          "2022-05-30T14:41:48.425Z" /*DateTime.now().toString()*/,
                                          true,
                                          true)
                                      .then((value) {
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      getUserId();
                                      dashboardController.getActivity(userId,
                                          _progressUpdateModel!.getidEvent!);
                                      progressUpdateController.progressUpdate(
                                        userId!,
                                        _progressUpdateModel!.getidEvent!,
                                        _progressUpdateModel!.getstatusActivity,
                                      ); //  getProgrssListAPICall(userId!);
                                    });

                                    delayHrs.text = "";
                                    description.text = "";

                                    widget.activityBarrierList =
                                        (widget.activityBarrierList?.toInt())! +
                                            1;
                                    print(widget.activityBarrierList);
                                  });
                                } else {
                                  barrierAddUpdateController.UpdateBarrierCode(
                                          barrierCodeId,
                                          activityCodeResponse!,
                                          userIdResponse!,
                                          _dropDownValue!.shortCode!,
                                          delayHrs.text,
                                          description.text,
                                          wbscodeResponse!,
                                          timeStampResponse! /*DateTime.now().toString()*/,
                                          true,
                                          true)
                                      .then((value) {
                                    setState(() {
                                      delayHrs.text = "";
                                      description.text = "";
                                      btnValue = Strings.add;
                                      isVisible = false;

                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        getUserId();
                                      });
                                    });
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: ThemeColors.appThemeColor,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  btnValue!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Visibility(
                            visible: isVisible!,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  delayHrs.text = "";
                                  description.text = "";
                                  btnValue = Strings.add;
                                  isVisible = false;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ThemeColors.appThemeColor,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(18.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    Strings.cancel,
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  GetBuilder<AvilableBarrierListController>(
                    init: AvilableBarrierListController(),
                    builder: (controllerBarrierList) {
                      return controllerBarrierList
                                  .avilableBarrierListController.length >
                              0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  Strings.assigned_barrier_code,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 18),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1.0,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                Strings.barrier_code,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            Strings.delay_hours,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Expanded(
                                          // flex: 2,
                                          child: Text(
                                        Strings.description,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      )),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controllerBarrierList
                                          .avilableBarrierListController.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onLongPress: () {
                                            setState(() {
                                              var barrierCodeResponse =
                                                  controllerBarrierList
                                                      .avilableBarrierListController[
                                                          index]
                                                      .barrierCode;

                                              for (int i = 0;
                                                  i <
                                                      controller
                                                          .barrierListRespnse
                                                          .length;
                                                  i++) {
                                                if (controller
                                                    .barrierListRespnse[i]!
                                                    .shortCode
                                                    .toString()
                                                    .contains(
                                                        barrierCodeResponse!
                                                            .toString())) {
                                                  _dropDownValue = controller
                                                      .barrierListRespnse[i];
                                                  break;
                                                }
                                              }
                                              barrierCodeId = controllerBarrierList
                                                  .avilableBarrierListController[
                                                      index]
                                                  .id;
                                              activityCodeResponse =
                                                  controllerBarrierList
                                                      .avilableBarrierListController[
                                                          index]
                                                      .activityId;
                                              wbscodeResponse =
                                                  controllerBarrierList
                                                      .avilableBarrierListController[
                                                          index]
                                                      .wbscode;
                                              timeStampResponse =
                                                  controllerBarrierList
                                                      .avilableBarrierListController[
                                                          index]
                                                      .timeStamp;

                                              userIdResponse = controllerBarrierList
                                                  .avilableBarrierListController[
                                                      index]
                                                  .userId;

                                              btnValue = Strings.update;
                                              isVisible = true;
                                            });
                                            // _dropDownValue?.shortCode!=

                                            delayHrs.text = controllerBarrierList
                                                .avilableBarrierListController[
                                                    index]
                                                .delayTime
                                                .toString();

                                            description.text =
                                                controllerBarrierList
                                                    .avilableBarrierListController[
                                                        index]
                                                    .barrierDescription
                                                    .toString();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            controllerBarrierList
                                                                .avilableBarrierListController[
                                                                    index]
                                                                .barrierCode
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            controllerBarrierList
                                                                .avilableBarrierListController[
                                                                    index]
                                                                .delayTime
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                      Expanded(
                                                          // flex: 2,
                                                          child: Text(
                                                        controllerBarrierList
                                                            .avilableBarrierListController[
                                                                index]
                                                            .barrierDescription
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      controllerBarrierList
                                                                  .avilableBarrierListController[
                                                                      index]
                                                                  .isDelete ==
                                                              true
                                                          ? InkWell(
                                                              onTap: () {
                                                                showLoader(
                                                                    "Are you sure you want to delete ?",
                                                                    controllerBarrierList,
                                                                    index);
                                                              },
                                                              child: Icon(
                                                                Icons.delete,
                                                                size: 18,
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: 18,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 1.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )
                          : Container();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showLoader(String msg,
      AvilableBarrierListController controllerBarrierList, int index) {
    Get.defaultDialog(
      barrierDismissible: true,
      title: '',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                msg,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            InkWell(
              onTap: () {
                deleteBarrierActivityController
                    .deleteBarrierActivity(controllerBarrierList
                        .avilableBarrierListController[index].activityId
                        .toString())
                    .then((value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    getUserId();
                  });
                });
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    Strings.yes,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      Strings.cancel,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(Preferences.userId);
    avilableBarrierListController.getBarrierList(
        int.parse(userId!), widget.activityCode!);
  }
}
