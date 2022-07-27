import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_architech/screen/dashboard.dart';
import '../common/strings.dart';
import '../common/utility.dart';
import '../controllers/eventlist_controller.dart';
import '../response/eventlist_response.dart';
import '../theme_colors.dart';

/* Created by Chetu */

class EventNameScreen extends StatefulWidget {

  // make global variable for userId
  int? userId;

  EventNameScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EventNameScreenState createState() => _EventNameScreenState();
}

class _EventNameScreenState extends State<EventNameScreen> {
  // find the controller for event list
  EventListController eventListController = Get.put(EventListController());
  @override
  void initState() {
    // method is used for save the data into hive
    super.initState();

    // method is used for call event list API
    eventListController.eventAPi(widget.userId);
  }

  EventList? _dropDownValue;
  int? idEvent;
  int i = 1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventListController>(
      init: EventListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              backgroundColor: ThemeColors.appThemeColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    Strings.event_name,
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
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 58.0, horizontal: 28.0),
              child: Stack(
                children: [
                  Column(
                    children: [


                      // fetch event list response
                      controller.eventListRespnse.length > 0
                          ? Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  hint: _dropDownValue == null
                                      ? Text(Strings.event_name)
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                            _dropDownValue!.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                      ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: Colors.black),
                                  items: controller.eventListRespnse.value.map(
                                    (e) {
                                      return DropdownMenuItem<EventList>(
                                        value: e!,
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 6),
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  e.name.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
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
                                    // method are used for show the value  of dropdown type of event list
                                    setState(() {
                                      _dropDownValue = val as EventList?;
                                      idEvent = _dropDownValue?.id;
                                    });
                                  },
                                  //value: "_dropDownValue",
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: Text(
                                    Strings.no_record_found,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 18),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                            primary: ThemeColors.appThemeColor),
                        onPressed: () {
                          if (_dropDownValue == null) {
                            Utility.showToast(Strings.eventnamechoose);
                          } else {
                            Get.to(DashBoardScreen(
                              idEvent: idEvent,
                            ));
                          }
                        },
                        child: Text(
                          Strings.next,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
