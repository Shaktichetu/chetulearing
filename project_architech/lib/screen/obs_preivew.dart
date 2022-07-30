/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timo/constants/strings.dart';
import 'package:timo/controllers/observation_history_controller.dart';
import 'package:timo/controllers/profile_controller.dart';
import 'package:timo/models/observation_list_response.dart';
import 'package:timo/screens/dashboardObservationpriview.dart';
import 'package:timo/screens/new_observation.dart';

class ObservationHistory extends StatefulWidget {
  @override
  State<ObservationHistory> createState() => _ObservationHistoryState();
}

class _ObservationHistoryState extends State<ObservationHistory> {
  ObservationHistoryController observationHistoryController =
      Get.put(ObservationHistoryController());
  ProfileController _profileController = Get.find();
  int? i = 1;

  List<bool>? isPublish = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController _controller = new TextEditingController();
  bool isReverse = false;
  bool isSort = true;
  bool isSortForTeacher = true;
  bool isSortForDate = true;
  bool isRefresh = true;

  @override
  void initState() {
    // Method is used for get the user Name
    //   profileController.getProfileData();

    // observationHistoryController.getUserName();

    // Method is used for get the observation list
    observationHistoryController.getObservationList2();

    */
/* Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
      });

    });*//*


    super.initState();
  }

  List<Data> newList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Obx(() {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Welcome, ${_profileController.profileDatas.value.firstname ?? ""} ${_profileController.profileDatas.value.lastname ?? ""} !',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          //UserApiProvider().getObservationList2();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewObservation(true)));
                        },
                        child: Text(
                          Strings.new_observation,
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 42.0,
                  color: Colors.transparent,
                ),
                Container(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14.0),
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      hintText: Strings.search,
                    ),
                    onChanged: (val) {
                      if (val.isEmpty) {
                        newList.clear();
                      }
                      searchOpration(val, observationHistoryController);
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    Strings.history_observation,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height - 420,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text.rich(
                                      TextSpan(
                                          text: Strings.obs,
                                          children: [
                                            WidgetSpan(
                                                child: isSort
                                                    ? Icon(Icons
                                                        .arrow_drop_up_outlined)
                                                    : Icon(Icons
                                                        .arrow_drop_down_outlined)),
                                          ],
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              sortListUsingObs(isSort);
                                            }),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text.rich(
                                        TextSpan(
                                            text: Strings.teacher,
                                            children: [
                                              WidgetSpan(
                                                  child: isSortForTeacher
                                                      ? Icon(Icons
                                                          .arrow_drop_up_outlined)
                                                      : Icon(Icons
                                                          .arrow_drop_down_outlined))
                                            ],
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                sortListUsingTeacher(
                                                    isSortForTeacher);
                                              }),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text.rich(
                                        TextSpan(
                                            text: Strings.date,
                                            children: [
                                              WidgetSpan(
                                                  child: isSortForDate
                                                      ? Icon(Icons
                                                          .arrow_drop_up_outlined)
                                                      : Icon(Icons
                                                          .arrow_drop_down_outlined))
                                            ],
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                sortListUsingDate(
                                                    isSortForDate);
                                              }),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Flexible(
                              child: Container(
                                height: Get.height - 450,
                                child: newList
                                        .isNotEmpty */
/*|| _controller.text.isNotEmpty*//*

                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        reverse: isReverse,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _getItemList(
                                              newList[index], isPublish, index);
                                        },
                                        itemCount: newList.length,
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        reverse: isReverse,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _getItemList(
                                              observationHistoryController
                                                  .historyList.value[index],
                                              isPublish,
                                              index);
                                        },
                                        itemCount: observationHistoryController
                                            .historyList.length,
                                      ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Method is used for show the list of observation list tile
  Widget _getItemList(Data historyList, List<bool>? isPublish, int index) {
    isPublish!.add(false);

    if (historyList.completed.toString() == Strings.number_completed) {
      isPublish[index] = true;
    } else {
      isPublish.add(false);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.0,
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(historyList.observationID.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(historyList.teacherName.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
              ),
              SizedBox(
                width: 80.0,
                child: Text(
                  historyList.date.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(DashBoardObservationPriview(
                          pos: index,
                          obsId: historyList.observationID.toString(),
                        ));
                      },
                      child: Icon(
                        CupertinoIcons.pen,
                        size: 20.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showAlertDialog(
                            context, historyList.observationID.toString());
                      },
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 20.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //Method are used for publish and unpublish the observation
                        showAlertDialogForPublish(
                            context,
                            index,
                            historyList.observationID.toString(),
                            historyList.completed.toString());
                      },
                      child: newList.isNotEmpty
                          ? historyList.completed == Strings.number_completed
                              ? Icon(
                                  CupertinoIcons.eye,
                                  size: 20.0,
                                )
                              : Icon(
                                  CupertinoIcons.eye_slash,
                                  size: 20.0,
                                )
                          : historyList.completed == Strings.number_completed
                              ? Icon(
                                  CupertinoIcons.eye,
                                  size: 20.0,
                                )
                              : Icon(
                                  CupertinoIcons.eye_slash,
                                  size: 20.0,
                                ),
                    ),
                    */
/* Icon(
                      CupertinoIcons.share,
                      size: 20.0,
                    ),*//*

                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 8.0,
          color: Colors.grey,
        )
      ],
    );
  }

  // Method is used for refresh the list when we pull, down the refresh
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // setState(()  {
    observationHistoryController.getObservationList2();
    observationHistoryController.historyList.refresh();

    observationHistoryController.onInit();

    Future.delayed(Duration(seconds: 1), () {
      if (newList.isNotEmpty) {
        for (int x = 0; newList.length > x; x++) {
          for (int y = 0;
              observationHistoryController.historyList.value.length > y;
              y++) {
            if (observationHistoryController
                    .historyList.value[y].observationID ==
                newList[x].observationID) {
              print(observationHistoryController
                      .historyList.value[y].observationID ==
                  newList[x].observationID);
              print(
                  "${newList[x].completed} = ${observationHistoryController.historyList.value[y].completed}");
              newList[x].completed =
                  observationHistoryController.historyList.value[y].completed;
              setState(() {});
            }
          }
        }
      }
    });

    _refreshController.refreshCompleted();
  }

  // Method is used for loading purpose until the data is loading
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  // Method is used for search opertaion of observation list.
  searchOpration(String value, ObservationHistoryController history) {
    newList.clear();
    if (value.contains(RegExp(r"[/]"))) {
      history.historyList.forEach((element) {
        //  newList.clear();
        if (element.date!
            .toLowerCase()
            .contains(value.toString().toLowerCase())) {
          newList.add(element);
          print(
              "${element.date},${element.teacherName},${element.observationID},${element.completed},${element.date},");
        }
      });
      setState(() {});
    } else if (value.contains(RegExp(r'[0-9]'))) {
      history.historyList.forEach((element) {
        //newList.clear();
        if (element.observationID!.contains(value)) {
          newList.add(element);
          print(
              "${element.date},${element.teacherName},${element.observationID},${element.completed},${element.date},");
        }
      });
      setState(() {});
    } else if (value.contains(RegExp(r'[a-z]'))) {
      history.historyList.value.forEach((element) {
        //newList.clear();
        if (element.teacherName!.toLowerCase().contains(value.toLowerCase())) {
          newList.add(element);
        }
        print(
            "${element.date},${element.teacherName},${element.observationID},${element.completed},${element.date},");
      });
      setState(() {});
    }
  }

  // Method is used for sort via OBS
  void sortListUsingObs(bool Sort) {
    if (Sort) {
      newList.clear();
      observationHistoryController.historyList.sort((a, b) =>
          int.parse(a.observationID!).compareTo(int.parse(b.observationID!)));
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSort = false;
      });
    } else {
      newList.clear();
      observationHistoryController.historyList.sort((a, b) =>
          int.parse(b.observationID!).compareTo(int.parse(a.observationID!)));
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSort = true;
      });
    }
  }

  // Method is used for sort via Teacher
  void sortListUsingTeacher(bool Sort) {
    if (Sort) {
      newList.clear();
      observationHistoryController.historyList.sort((a, b) {
        return a.teacherName!
            .toLowerCase()
            .compareTo(b.teacherName!.toLowerCase());
      });
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSortForTeacher = false;
      });
    } else {
      newList.clear();
      observationHistoryController.historyList.sort((a, b) =>
          b.teacherName!.toLowerCase().compareTo(a.teacherName!.toLowerCase()));
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSortForTeacher = true;
      });
    }
  }

  // Method is used for sort via Date
  void sortListUsingDate(bool Sort) {
    if (Sort) {
      newList.clear();
      observationHistoryController.historyList
          .sort((a, b) => a.date!.compareTo(b.date!));
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSortForDate = false;
      });
    } else {
      newList.clear();
      observationHistoryController.historyList
          .sort((a, b) => b.date!.compareTo(a.date!));
      observationHistoryController.historyList.forEach((element) {
        newList.add(element);
      });
      setState(() {
        isSortForDate = true;
      });
    }
  }

  // Method is used for show the alert msg
  showAlertDialog(BuildContext context, String observationID) {
    Widget cancelButton = TextButton(
      child: Text(Strings.cancel),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(Strings.continue_),
      onPressed: () {
        observationHistoryController.deleteObs(observationID);
        setState(() {
          _controller.clear();
          newList.clear();
        });
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text(Strings.alert),
      content: Text(Strings.alertdeleteobs),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Method is used for publish and unpublish the observation list.
  showAlertDialogForPublish(
      BuildContext context, int pos, String observationID, String completed) {
    String publishOrNot = "";
    if (completed == Strings.number_completed) {
      publishOrNot = Strings.unpublish_small;
    } else {
      publishOrNot = Strings.publish_small;
    }
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Strings.cancel),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
        child: Text(Strings.continue_),
        onPressed: () {
          EasyLoading.show(status: Strings.loading);

          // if (isPublish![pos]) {
          if (completed.toString() == Strings.number_completed) {
            observationHistoryController.observationPublish(
                2, int.parse(observationID));
            isPublish![pos] = false;
            if (newList.isNotEmpty) {
              newList[pos].completed = Strings.number_completed2;
            }
            // i = 2;
          } else {
            observationHistoryController.observationPublish(
                1, int.parse(observationID));
            isPublish![pos] = true;
            if (newList.isNotEmpty) {
              newList[pos].completed = Strings.number_completed;
            }
            // newList[pos].completed = "";
            // i = 1;
          }
          Get.back();
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text(Strings.alert),
      content: Text("Are you sure you want to $publishOrNot this observation?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

// class is used for design of list items
class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text(Strings.entry_a)),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text(Strings.entry_b)),
            ),
          ],
        ),
      ),
    );
  }
}
*/
