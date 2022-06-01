/*
 * Created by - Chetu India .
 * Description - This Class is used for defining all the Strings used in this project.
 */

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valid_get/strings.dart';

class ContactDetailsController extends GetxController {
  
  final phoneNumberController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final zipCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final GlobalKey<FormFieldState> phoneNumberFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> addressLine1FormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> addressLine2FormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> zipCodeFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> cityFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stateFormKey = GlobalKey<FormFieldState>();
  final contactDetailsFormKey = GlobalKey<FormState>();

  // boolean values to check various conditions.
  bool isSubmitButtonEnabled = false;
  var visible = false.obs;

  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
   
    
  }

  // Phone Number Validation
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone Number Can't be empty";
    } else if (value.length < 14) {
      return "Phone Number must be 10 digits";
    } else {
      return Strings.valid;
    }
  }

  // AddressLine1 Validation
  String? validateAddressLine1(String value) {
    if (value.isEmpty) {
      return "Address Can't be empty";
    } else if (value.length < 5) {
      return "Address must be 5 characters";
    } else {
      return Strings.valid;
    }
  }

  // City Validation
  String? validateCity(String value) {
    if (value.isEmpty) {
      return "City Can't be empty";
    } else if (value.length < 3) {
      return "City must be 3 characters";
    } else {
      return Strings.valid;
    }
  }

  // State Validation
  String? validateState(String value) {
    if (value.isEmpty) {
      return "State Can't be empty";
    } else if (value.length < 3) {
      return "State must be 3 characters";
    } else {
      return Strings.valid;
    }
  }

  // Zip Code Validation
  String? validateZipCode(String value) {
    if (value.isEmpty) {
      return "Zip Code Can't be empty";
    } else if (value.length < 5) {
      return "Zip Code must be 5 characters";
    } else {
      return Strings.valid;
    }
  }

  
  // Returning bool for form validation
  bool isFormValid() {
    return ((phoneNumberFormKey.currentState!.isValid &&
        addressLine1FormKey.currentState!.isValid &&
        zipCodeFormKey.currentState!.isValid &&
        cityFormKey.currentState!.isValid));
  }

 
  // login request to get token
  
  @override
  void onClose() {
    super.onClose();
    
  }
}
