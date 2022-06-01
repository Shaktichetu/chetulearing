import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:valid_get/strings.dart';
import 'package:validators/validators.dart';


class SignupController extends GetxController {
  late var usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormFieldState> usernameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmPasswordFormKey =
      GlobalKey<FormFieldState>();
  final signupFormKey = GlobalKey<FormState>();
  // boolean values to check various conditions.
  bool isSubmitButtonEnabled = false;
  bool visible = false;
  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  var validUser = false.obs;
  var validEmail = false.obs;
  late var user = usernameController.text;
  late var email = emailController.text;
  late var password = passwordController.text;

  @override
  void onInit() {
    // usernameController.clear();
    // emailController.clear();
    // passwordController.clear();
    super.onInit();
  }

  // Username Validation
  String? validateUser(String value) {
    if (value.isEmpty) {
      return Strings.userCantEmpty;
    } else if (value.length < 4) {
      return Strings.userMustBe;
    } else {
      return Strings.valid;
    }
  }
  

  // Email Validation
  String? validateUserEmail(String value) {
    if (value.isEmpty) {
      return Strings.userCantEmpty;
    } else if (!isEmail(value)) {
      return Strings.enterValidUserId;
    } else {
      return Strings.valid;
    }
  }

  // Password Validation
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return Strings.passwordCantEmpty;
    } else if (value.length < 8) {
      return Strings.passwordMustBe;
    } else {
      return Strings.valid;
    }
  }

  // Password Validation
  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return Strings.passwordCantEmpty;
    } else if (value.length < 8) {
      return Strings.passwordMustBe;
    } else if (value != (passwordController.text)) {
      return "Must match entered password";
    } else {
      return Strings.valid;
    }
  }

  // Returning bool for form validation
  bool isFormValid() {
    return ((usernameFormKey.currentState!.isValid &&
        passwordFormKey.currentState!.isValid &&
        emailFormKey.currentState!.isValid));
  }

  void signupPersonal() {
    // var user = usernameController;
    // var email = emailController.text;
    // var password = passwordController.text;

    if (isFormValid()) {
    //  Get.to(() => PersonalSignup(), arguments: [user, email, password]);
    }
    
    // usernameController.text = "";
    // emailController.text = "";
    // passwordController.text = "";
  }

// void signupClear() {

//   }

  @override
  void onClose() {
    // TODO: implement onClose
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }

  // void dispose() {
  //   super.dispose();
  //   // usernameController.text = "";
  //   // emailController.text = "";
  //   // passwordController.text = "";
  //   usernameController.close();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }
}
