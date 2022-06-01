import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_get/strings.dart';

import 'app_colors.dart';
import 'app_images.dart';
import 'contact_details_controller.dart';

class ContactDetails extends StatefulWidget {
  ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final ContactDetailsController contactDetailsController =
      Get.put(ContactDetailsController());

  bool stateVisible = true;
  showAlertDialog(BuildContext context, String error) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.back();
      },
    );

    // set up the button
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(error),
      actions: [
        okButton,
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

  final List<ListItem> _dropdownItems = [
    ListItem("Alabama", "Alabama (AL)"),
    ListItem("Alaska", "Alaska (AK)"),
    ListItem("Arizona", "Arizona (AZ)"),
    ListItem("Arkansas", "Arkansas (AR)"),
    ListItem("California", "California (CA)"),
    ListItem("Connecticut", "Connecticut (CT)"),
    ListItem("District of Columbia", "District of Columbia (DC)"),
    ListItem("Delaware", "Delaware (DE)"),
    ListItem("Florida", "Florida (FL)"),
    ListItem("Georgia", "Georgia (GA)"),
    ListItem("Hawaii", "Hawaii (HI)"),
    ListItem("Idaho", "Idaho (ID)"),
    ListItem("Illinois", "Illinois (IL)"),
    ListItem("Indiana", "Indiana (IN)"),
    ListItem("Iowa", "Iowa (IA)"),
    ListItem("Kansas", "Kansas (KS)"),
    ListItem("Kentucky", "Kentucky (KY)"),
    ListItem("Louisiana", "Louisiana (LA)"),
    ListItem("Maine", "Maine (ME)"),
    ListItem("Maryland", "Maryland (MD)"),
    ListItem("Massachusetts", "Massachusetts (AR)"),
    ListItem("Michigan", "Michigan (MI)"),
    ListItem("Minnesota", "Minnesota (MN)"),
    ListItem("Mississippi", "Mississippi (MS)"),
    ListItem("Missouri", "Missouri (MO)"),
    ListItem("Montana", "Montana (MT)"),
    ListItem("Nebraska", "Nebraska (NE)"),
    ListItem("Nevada", "Nevada (NV)"),
    ListItem("New Hampshire", "New Hampshire (NH)"),
    ListItem("New Jersey", "New Jersey (NJ)"),
    ListItem("New Mexico", "New Mexico (NM)"),
    ListItem("New York", "New York (NY)"),
    ListItem("North Carolina", "North Carolina (NC)"),
    ListItem("North Dakota", "North Dakota (ND)"),
    ListItem("Ohio", "Ohio (OH)"),
    ListItem("Oklahoma", "Oklahoma (OK)"),
    ListItem("Oregon", "Oregon (OR)"),
    ListItem("Pennsylvania", "Pennsylvania (PA)"),
    ListItem("Rhode Island", "Rhode Island (RI)"),
    ListItem("South Carolina", "South Carolina (SC)"),
    ListItem("South Dakota", "South Dakota (SD)"),
    ListItem("Tennessee", "Tennessee (TN)"),
    ListItem("Texas", "Texas (TX)"),
    ListItem("Utah", "Utah (UT)"),
    ListItem("Vermont", "Vermont (VT)"),
    ListItem("Virginia", "Virginia (VA)"),
    ListItem("Washington", "Washington (WA)"),
    ListItem("West Virginia", "West Virginia (WV)"),
    ListItem("Wisconsin", "Wisconsin (WI)"),
    ListItem("American Samoa", "American Samoa (AS)"),
    ListItem("Guam", "Guam (GU)"),
    ListItem("Northern Mariana Islands", "Northern Mariana Islands (MP)"),
    ListItem("Puerto Rico", "Puerto Rico (PR)"),
    ListItem("US Virgin Islands", "Wyoming (VI)"),
    ListItem("Washington, DC", "Washington, DC (DC)"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _selectedItem;

  void initState() {
    super.initState();

    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);

    _selectedItem = _dropdownMenuItems![0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    customDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: Colors.grey.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: 310,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff0000006E),
                        blurRadius: 2.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Your profile has been submitted",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "MontserratLight",
                                shadows: [
                                  Shadow(
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 2.0,
                                    color: Color(0xff0000006E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "SUCCESSFULLY",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "MontserratMedium"),
                      ),
                      SizedBox(height: 32),
                      InkWell(
                        onTap: () {
                          //  Get.offAll(() => Dashboard());
                        },
                        child: Container(
                            width: 81,
                            height: 37,
                            margin: EdgeInsets.fromLTRB(16, 0, 32, 0),
                            // width: 142,
                            padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Text(
                              "OK",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "RobotoRegular"),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.bgColor,
                AppColors.black,
                AppColors.black
              ])),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // Get.offAll(() => Dashboard());
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.accentColor,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.0),
                          child: Text(
                            "Edit Contact Details",
                            style: TextStyle(
                                color: AppColors.accentColor,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.account_circle,
                      color: AppColors.doveGray,
                      size: 100.0,
                    ),
                   
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Card(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            width: Get.width * .75,
                            child: GetBuilder<ContactDetailsController>(
                              init: ContactDetailsController(),
                              builder: (data) => TextFormField(
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  contactDetailsController
                                          .isSubmitButtonEnabled =
                                      contactDetailsController
                                          .isFormValid();
                                  contactDetailsController
                                      .phoneNumberFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = contactDetailsController
                                      .validatePhoneNumber(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller: contactDetailsController
                                    .phoneNumberController,
                                key: contactDetailsController
                                    .phoneNumberFormKey,
                                style:
                                    const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Phone Number',
                                  prefixIcon: const Icon(
                                    Icons.phone_android,
                                    color: AppColors.white,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            width: Get.width * 0.75,
                            child: GetBuilder<ContactDetailsController>(
                              init: ContactDetailsController(),
                              builder: (data) => TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                onChanged: (value) {
                                  contactDetailsController
                                          .isSubmitButtonEnabled =
                                      contactDetailsController
                                          .isFormValid();
                                  contactDetailsController
                                      .addressLine1FormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = contactDetailsController
                                      .validateAddressLine1(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller: contactDetailsController
                                    .addressLine1Controller,
                                key: contactDetailsController
                                    .addressLine1FormKey,
                                style:
                                    const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Address Line 1',
                                  prefixIcon: const Icon(
                                    Icons.contact_mail,
                                    color: AppColors.white,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            width: Get.width * 0.75,
                            child: GetBuilder<ContactDetailsController>(
                              init: ContactDetailsController(),
                              builder: (data) => TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                onChanged: (value) {},
                                controller: contactDetailsController
                                    .addressLine2Controller,
                                key: contactDetailsController
                                    .addressLine2FormKey,
                                style:
                                    const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Address Line 2 (Optional)',
                                  prefixIcon: const Icon(
                                    Icons.contact_mail,
                                    color: AppColors.white,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            width: Get.width * 0.75,
                            child: GetBuilder<ContactDetailsController>(
                              init: ContactDetailsController(),
                              builder: (data) => TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                onChanged: (value) {
                                  contactDetailsController
                                          .isSubmitButtonEnabled =
                                      contactDetailsController
                                          .isFormValid();
                                  contactDetailsController
                                      .cityFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = contactDetailsController
                                      .validateCity(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller:
                                    contactDetailsController.cityController,
                                key: contactDetailsController.cityFormKey,
                                style:
                                    const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'City',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4.0, bottom: 8),
                          child: Container(
                            height: 58,
                            width: Get.width * 0.75,
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.drawerColor,
                                border: Border.all(
                                    color: AppColors.white, width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    dropdownColor: AppColors.green,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    value: _selectedItem,
                                    items: _dropdownMenuItems,
                                    iconEnabledColor: Colors.green,
                                    onChanged: (ListItem? value) {
                                      setState(() {
                                        _selectedItem = value!;
                                        debugPrint(_selectedItem!.name);
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width * 0.75,
                            child: GetBuilder<ContactDetailsController>(
                              init: ContactDetailsController(),
                              builder: (data) => TextFormField(
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  contactDetailsController
                                          .isSubmitButtonEnabled =
                                      contactDetailsController
                                          .isFormValid();
                                  contactDetailsController
                                      .zipCodeFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = contactDetailsController
                                      .validateZipCode(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller: contactDetailsController
                                    .zipCodeController,
                                key:
                                    contactDetailsController.zipCodeFormKey,
                                style:
                                    const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Zip Code',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<ContactDetailsController>(
                          init: ContactDetailsController(),
                          builder: (data) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 10.0),
                            width: double.infinity,
                            child: TextButton(
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: AppColors.green,
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal),
                                ),
                                onPressed: () {
                                  if (contactDetailsController
                                      .phoneNumberFormKey.currentState!
                                      .validate()) {
                                    if (contactDetailsController
                                        .addressLine1FormKey.currentState!
                                        .validate()) {
                                      if (contactDetailsController
                                          .cityFormKey.currentState!
                                          .validate()) {
                                        if (contactDetailsController
                                            .zipCodeFormKey.currentState!
                                            .validate()) {
                                          debugPrint(
                                              "Validation Successful");
                                        }
                                      }
                                    }
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: AppColors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                      child: Text(
                    "Your Contact details has been updated",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                    ),
                  )),
                  Center(
                    child: Text("Successfully",
                        style:
                            TextStyle(color: AppColors.white, fontSize: 35.0)),
                  )
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

showAlert(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            AppImages.logo,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ]),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text(
              Strings.ok,
              style: TextStyle(
                color: AppColors.doveGray,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              //  getSubmitRenewal();
            },
          ),
        ],
      );
    },
  );
}

class ListItem {
  String value;
  String name;
  ListItem(this.value, this.name);
}
