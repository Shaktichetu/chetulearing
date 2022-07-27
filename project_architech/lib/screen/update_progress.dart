import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:project_architech/screen/progress_update_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/strings.dart';
import '../common/utility.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/progress_update_controller.dart';
import '../controllers/update_task_activity_controller.dart';
import '../model/progress_update_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../sharedpref/constants/preferences.dart';
import '../theme_colors.dart';
import 'barrier_code_add_update.dart';

/* Created by Chetu */

class UpdateProgressScreen extends StatefulWidget {
  String? startDate;
  String? endDate;
  int? currentPercentComplete;
  String? activityCode;
  String? activityDescription;
  String? wbscode;
  String? dataDate;
  int? activityBarrierList;
  int? id;

  UpdateProgressScreen(
      {Key? key,
      this.id,
      this.startDate,
      this.endDate,
      this.activityCode,
      this.currentPercentComplete,
      this.activityDescription,
      this.wbscode,
      this.activityBarrierList,this.dataDate})
      : super(key: key);

  @override
  State<UpdateProgressScreen> createState() => _UpdateProgressScreenState();
}

class _UpdateProgressScreenState extends State<UpdateProgressScreen> {
  DateTime? dt;
  String? startDateEvent;
  String? EndDateEvent;
  String? userId;
  String? dataDate;

  bool? finishDate =  false;
  ProgressUpdateModel? _progressUpdateModel;

  TextEditingController percentCompleteController =
      TextEditingController(text: '');
  UpdateTaskActivityController updateTaskActivityController =
      Get.put(UpdateTaskActivityController());
  ProgressUpdateController progressUpdateController =
      Get.put(ProgressUpdateController());
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController? textEditingController  = TextEditingController(text: '');
  TextEditingController? endDateEditingController=TextEditingController(text: '');

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finishDate = false;
    _progressUpdateModel = Utility.getProgressUpdateModel();
    percentCompleteController.text = widget.currentPercentComplete.toString();
    print("startDateEvent");

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

    try {
      DateTime dt = DateTime.parse(widget.startDate.toString());
      // startDateEvent = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
      startDateEvent = DateFormat(Strings.dateformat_).format(dt);
      print("startDateEvent");
      print(startDateEvent);
      setStartEventDate(startDateEvent!);
    // textEditingController = TextEditingController(text: startDateEvent);
  //   endDateEditingController = TextEditingController(text: EndDateEvent);
    } catch (error , stacktrace) {
      print("Exception occured StartDate: $error stackTrace: $stacktrace");
    }

    try {
      DateTime dtEndDate = DateTime.parse(widget.endDate.toString());
      print("EndDateEvent");

      EndDateEvent = DateFormat(Strings.dateformat_).format(dtEndDate);
      print(EndDateEvent);
      setEndEventDate(EndDateEvent!,true);
    // textEditingController = TextEditingController(text: startDateEvent);
  //   endDateEditingController = TextEditingController(text: EndDateEvent);
    } catch (error , stacktrace) {
      print("Exception occured EndDate: $error stackTrace: $stacktrace");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.update_progress,
          ),
          InkWell(
            onTap: () {
              Utility.showLoaderLogout("Are You Sure You want to Logout ?");
            },
            child: Icon(
              Icons.logout,
            ),
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
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
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(18,18,18,8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Strings.actual_start,
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
                              //   Icon(CupertinoIcons.asterisk_circle_fill,size: 12,color: Colors.red,),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: Get.width,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: DateTimePicker(
                                          controller: textEditingController,
                                          type: DateTimePickerType.dateTime,
                                          // dateMask: "d-MM-yyyy HH:mm:ss",
                                          dateMask: Strings.dateMask_,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          icon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.grey,
                                          ),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero),
                                          onChanged: (val) {
                                            setState(() {
                                              // startDateEvent = val;
                                              textEditingController!.text = val;
                                              DateTime dt = DateTime.parse(
                                                  textEditingController!.text
                                                      .toString());
                                              textEditingController!.text =
                                                  DateFormat(
                                                          Strings.dateformat_)
                                                      .format(dt);
                                            });
                                          },
                                          validator: (val) {
                                            return null;
                                          },
                                          onSaved: (val) {}),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    setStartEventDate("");
                                  });
                                },
                                child:Icon(Icons.clear,color: ThemeColors.appThemeColor,),

    ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.actual_finish,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              //Icon(CupertinoIcons.asterisk_circle_fill,size: 12,color: Colors.red,),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: Get.width,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: DateTimePicker(
                                          controller: endDateEditingController,
                                          type: DateTimePickerType.dateTime,
                                          dateMask: Strings.dateMask_,
                                          // initialValue: EndDateEvent,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(4100),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero),
                                          onChanged: (val) {
                                            setState(() {
                                              endDateEditingController!.text =
                                                  val;
                                              DateTime dtEndDate =
                                                  DateTime.parse(endDateEditingController!.text);
                                              endDateEditingController!.text =
                                                  DateFormat(
                                                          Strings.dateformat_)
                                                      .format(dtEndDate);
                                              finishDate = true;
                                              percentCompleteController.text ="100";
                                            });
                                            print(val);
                                          },
                                          validator: (val) {
                                            print(val);
                                            return null;
                                          },
                                          onSaved: (val) {
                                            print(val);
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {

                                    setState(() {

                                      finishDate = false;
                                     print(finishDate);
                                      percentCompleteController.text="";
                                      setEndEventDate(null,finishDate!);
                                  });
                                },
                                child: Icon(Icons.clear,color: ThemeColors.appThemeColor,),

    ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.percent_complete,
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
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: Get.width,
                                  child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return Strings
                                                  .enter_percent_complete;
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          controller: percentCompleteController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    percentCompleteController.text = "";
                                  });
                                },
                                child:Icon(Icons.clear,color: ThemeColors.appThemeColor,),
                               /* Text(
                                  'Clear',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),*/
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(BarrierCodeAddUpdateScreen(
                                startDate: widget.startDate,
                                endDate: widget.endDate,
                                currentPercentComplete:
                                    widget.currentPercentComplete,
                                activityCode: widget.activityCode,
                                wbscode: widget.wbscode,
                                activityDescription: widget.activityDescription,
                                activityBarrierList: widget.activityBarrierList,
                              ));
                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ThemeColors.appThemeColor,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(18.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: widget.activityBarrierList == 0
                                      ? Text(
                                          Strings.select_barrier_code,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      : Text(
                                          Strings.select_barrier_code +
                                              " (${widget.activityBarrierList}) ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                )),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          InkWell(
                            onTap: () {


                              if(finishDate!){

                                print('got to finish true');
                                // gotoWithFinishDate();
                                if (textEditingController!.text == null ||
                                    textEditingController!.text == "") {
                                  Utility.showLoader(
                                      Strings.please_enter_actual_start_date);

                                  // Utility.showToast("Please Enter Actual Start Date");
                                }
                                else if (textEditingController!.text
                                        .compareTo(endDateEditingController!.text) <
                                    0) {
                                 if (percentCompleteController.text.isEmpty ||
                                    percentCompleteController.text == null) {
                                  Utility.showLoader(
                                      Strings.please_enter_percent_complete);
                                }else if(int.parse(
                                     percentCompleteController.text) ==
                                     100){
                                 // else{
                                   updateTaskActivityController
                                       .updateTask(
                                       context,
                                       widget.activityCode!,
                                       int.parse(
                                           percentCompleteController.text),
                                       textEditingController!.text,
                                       endDateEditingController!.text)
                                       .then((value) {

                                         setState(() {

                                         });
                                     Future.delayed(
                                         const Duration(milliseconds: 300), () {
                                    //   getUserId();
                                       dashboardController.getActivity(userId,
                                           _progressUpdateModel!.getidEvent!);
                                      //  getProgrssListAPICall(userId!);
                                     });


                                     Future.delayed(
                                         Duration(microseconds: 400), () {
                                       getUserId();

                                     });


                                  Navigator.of(context).pop();
                                     // Get.off(ProgressUpdateScreen());
                                     Navigator.of(context).pushReplacement(
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 ProgressUpdateScreen()));
                                   });
                                 } else {
                                       Utility.showLoader(
                                           "Percent Complete Should Be 100");
                                     }
                                }else {
                                  Utility.showLoader(
                                      Strings.start_should_be_greater);
                                }
                              }else{
                                print('got to finish false'+textEditingController!.text.toString());



                                if (textEditingController!.text.isEmpty ||
                                    textEditingController!.text == null) {
                                  Utility.showLoader(
                                      Strings.please_enter_actual_start_date);

                                  // Utility.showToast("Please Enter Actual Start Date");
                                }
                              /*  else if (textEditingController!.text
                                    .compareTo(endDateEditingController!.text) <
                                    0) {*/
                                 else if (percentCompleteController.text.isEmpty ||
                                      percentCompleteController.text == null) {
                                    Utility.showLoader(
                                        Strings.please_enter_percent_complete);
                                  }else if(int.parse(
                                      percentCompleteController.text) <
                                      100){
                                    // else{
                                    updateTaskActivityController
                                        .updateTask(
                                        context,
                                        widget.activityCode!,
                                        int.parse(
                                            percentCompleteController.text),
                                        textEditingController!.text,
                                        null)
                                        .then((value) {

                                      setState(() {

                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 300), () {
                                       // getUserId();
                                        dashboardController.getActivity(userId,
                                            _progressUpdateModel!.getidEvent!);

                                      });


                                      Future.delayed(
                                          Duration(microseconds: 400), () {
                                            getUserId();
                                        // progressUpdateController.progressUpdate(
                                        //   userId!,
                                        //   _progressUpdateModel!.getidEvent!,
                                        //   _progressUpdateModel!.getstatusActivity,
                                        // ); //  getProgrssListAPICall(userId!);
                                      });

                                    Navigator.of(context).pop();
                                      // Get.off(ProgressUpdateScreen());
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProgressUpdateScreen()));
                                    });
                                  } else {
                                    Utility.showLoader(
                                        "Percent Complete Less than 100");
                                  }
                                }
                              /*  else {
                                  Utility.showLoader(
                                      Strings.start_should_be_greater);
                                }*/

                        /*        if (textEditingController!.text == null ||
                                    textEditingController!.text == "") {
                                  Utility.showLoader(
                                      Strings.please_enter_actual_start_date);

                                  // Utility.showToast("Please Enter Actual Start Date");
                                } else if (percentCompleteController.text.isEmpty ||
                                    percentCompleteController.text == null) {
                                  Utility.showLoader(
                                      Strings.please_enter_percent_complete);
                                }
                                else{
                                  updateTaskActivityController
                                      .updateTask(
                                      context,
                                      widget.activityCode!,
                                      int.parse(
                                          percentCompleteController.text),
                                      textEditingController!.text,
                                      null)
                                      .then((value) {
                                    Future.delayed(
                                        Duration(microseconds: 500), () {
                                      getUserId();
                                    });

                                    Navigator.of(context).pop();
                                    // Get.off(ProgressUpdateScreen());
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProgressUpdateScreen()));
                                  });
                                }*/


                              /* else if (endDateEditingController!.text == null ||
                              endDateEditingController!.text == "") {
                                if (percentCompleteController.text.isEmpty ||
                                    percentCompleteController.text == null) {
                                  Utility.showLoader(
                                      Strings.please_enter_percent_complete);
                                }*/

                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ThemeColors.appThemeColor,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    Strings.save,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
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
  }

  void getDateTime() {
    DateTime dt = DateTime.parse(widget.startDate.toString());
  }

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(Preferences.userId);
    progressUpdateController.progressUpdate(
      userId!,
      _progressUpdateModel!.idEvent!,
      _progressUpdateModel!.statusActivity!,
    );
    // method is used for get the list of progress
  }

  Future<Widget> selectDate() async {
    await DateTimePicker(
        type: DateTimePickerType.dateTime,
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) {
          print(val);
        });
    return DateTimePicker();
  }

  Future<void> getFinishDateTime() async {
    await DateTimePicker(
        icon: Icon(Icons.access_alarm),
        type: DateTimePickerType.dateTime,
        dateMask: Strings.dateMask_,
        initialValue: EndDateEvent,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        decoration: InputDecoration(
            border: InputBorder.none, contentPadding: EdgeInsets.zero),
        onChanged: (val) {
          setState(() {
            EndDateEvent = val;
            DateTime dtEndDate = DateTime.parse(EndDateEvent!);
            EndDateEvent = DateFormat(Strings.dateformat_).format(dtEndDate);
          });
          print(val);
        },
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) {
          print(val);
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(startDateEvent!),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.parse(startDateEvent!)) {
      setState(() {
        var selectedDate = picked;
        print(selectedDate);
        //_selectTime(context);
      });
    }
  }

/*  Future<Null> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12,minute:  8),
    );
*/ /*    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });*/ /*
  }*/
  Future<void> _selectDate1(BuildContext context) async {
    await showDateRangePicker(
        lastDate: DateTime(2022, 8),
        context: context,
        firstDate: DateTime(2015, 8));
  }

  void setStartEventDate(String startDateEvent) {
    try {
      setState(() {
        textEditingController = TextEditingController(text: startDateEvent);
        // textEditingController?.text = "";
      });
    } catch (Exception) {}
  }

  void setEndEventDate(String? endDateEvent,bool finishDate) {
    try {
      setState(() {
        endDateEditingController = TextEditingController(text: endDateEvent);
        // endDateEditingController?.text = "";
        finishDate = finishDate;
      });
    } catch (Exception) {}
  }

  void gotoWithFinishDate() {}

  }
/*  DatePicker.showDateTimePicker(context, showTitleActions: true,
  onChanged: (date) {
  print('change $date in time zone ' +
  date.timeZoneOffset.inHours.toString());
  }, onConfirm: (date) {
  print('confirm $date');
  }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));*/

