import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:valid_get/strings.dart';
import 'app_colors.dart';
import 'app_images.dart';
import 'signup_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  //final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignupController());
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
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 179.0,
                    height: 150.0,
                  ),
                ),
                Stack(children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 26, 0.0, 0.0),
                      width: 128,
                      child: const Divider(
                        color: AppColors.green,
                        thickness: 2,
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        Strings.register,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.0,
                            fontFamily: "MontserratLight"),
                      ),
                    ),
                  ),
                ]),
                const Center(
                  child: Text(
                    Strings.enterDetails,
                    style: TextStyle(
                        color: AppColors.subHeadingColor,
                        fontSize: 10.0,
                        fontFamily: "MontserratMedium"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 18.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.dotGreen,
                          width: 10.0,
                          height: 10.0,
                        ),
                        Image.asset(
                          AppImages.dashLineBlack,
                          width: 90.0,
                        ),
                        Image.asset(
                          AppImages.dotWhite,
                          width: 10.0,
                          height: 10.0,
                        ),
                        Image.asset(
                          AppImages.dashLineBlack,
                          width: 90.0,
                        ),
                        Image.asset(
                          AppImages.dotWhite,
                          width: 10.0,
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 35.0),
                  child: Card(
                    color: AppColors.fieldColor,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: AppColors.borderColor, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 2.0, color: Colors.green),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        Strings.register,
                                        style: TextStyle(
                                            color: AppColors.green,
                                            fontSize: 16.0,
                                            fontFamily: "RobotoRegular"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  Strings.personalDetails,
                                  style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16.0,
                                      fontFamily: "RobotoRegular"),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  Strings.contactDetails,
                                  style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16.0,
                                      fontFamily: "RobotoRegular"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            width: Get.width * 0.75,
                            child: Obx(
                              () => TextFormField(
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  signupController.isSubmitButtonEnabled =
                                      signupController.isFormValid();
                                  signupController.usernameFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error =
                                      signupController.validateUser(value!);
                                  if (error == Strings.valid) {
                                    signupController.validUser.value = true;
                                  } else {
                                    signupController.validUser.value = false;
                                  }
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller: signupController.usernameController,
                                key: signupController.usernameFormKey,
                                style: const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightBlack,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: Strings.userNameHint,
                                  hintStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontFamily: "MontserratMedium"),
                                  suffixIcon: Visibility(
                                    visible: signupController.validUser.value,
                                    child: Image.asset(
                                      AppImages.checkCircleIcon,
                                      scale: 1.4,
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    AppImages.userIcon,
                                    scale: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            width: Get.width * 0.75,
                            child: Obx(
                              () => TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  signupController.isSubmitButtonEnabled =
                                      signupController.isFormValid();
                                  signupController.emailFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = signupController
                                      .validateUserEmail(value!);
                                  if (error == Strings.valid) {
                                    signupController.validEmail.value = true;
                                  } else {
                                    signupController.validEmail.value = false;
                                  }
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                controller: signupController.emailController,
                                key: signupController.emailFormKey,
                                style: const TextStyle(color: AppColors.white),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightBlack,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: Strings.email,
                                  hintStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontFamily: "MontserratMedium"),
                                  suffixIcon: Visibility(
                                    visible: signupController.validEmail.value,
                                    child: Image.asset(
                                      AppImages.checkCircleIcon,
                                      scale: 1.4,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: AppColors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: Get.width * 0.75,
                            child: Obx(
                              () => TextFormField(
                                obscureText:
                                    signupController.passwordVisible.value,
                                controller: signupController.passwordController,
                                key: signupController.passwordFormKey,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(25),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  ),
                                ],
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (value) {
                                  signupController.isSubmitButtonEnabled =
                                      signupController.isFormValid();
                                  signupController.passwordFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error =
                                      signupController.validatePassword(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                style: const TextStyle(color: AppColors.white),
                                //  obscureText: loginController.passwordVisible,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightBlack,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: Strings.passwordHint,
                                  hintStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontFamily: "MontserratMedium"),
                                  prefixIcon: Image.asset(
                                    AppImages.lockIcon,
                                    scale: 1.4,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      signupController.passwordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of passwordVisible variable
                                      if (signupController
                                          .passwordVisible.value) {
                                        signupController.passwordVisible.value =
                                            false;
                                      } else {
                                        signupController.passwordVisible.value =
                                            true;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: Get.width * 0.75,
                            child: Obx(
                              () => TextFormField(
                                obscureText: signupController
                                    .confirmPasswordVisible.value,
                                controller:
                                    signupController.confirmPasswordController,
                                key: signupController.confirmPasswordFormKey,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(25),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  ),
                                ],
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (value) {
                                  signupController.isSubmitButtonEnabled =
                                      signupController.isFormValid();
                                  signupController
                                      .confirmPasswordFormKey.currentState!
                                      .validate();
                                },
                                validator: (value) {
                                  String? error = signupController
                                      .validateConfirmPassword(value!);
                                  return (error == Strings.valid)
                                      ? null
                                      : error;
                                },
                                style: const TextStyle(color: AppColors.white),
                                //  obscureText: loginController.passwordVisible,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightBlack,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: Strings.confirmPassword,
                                  hintStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontFamily: "MontserratMedium"),
                                  prefixIcon: Image.asset(
                                    AppImages.lockIcon,
                                    scale: 1.4,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      signupController
                                              .confirmPasswordVisible.isTrue
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of passwordVisible variable
                                      if (signupController
                                          .confirmPasswordVisible.value) {
                                        signupController.confirmPasswordVisible
                                            .value = false;
                                      } else {
                                        signupController.confirmPasswordVisible
                                            .value = true;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          height: 45.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 30.0),
                          width: Get.width * 0.75,
                          child: TextButton(
                            child: const Text(
                              Strings.next,
                              style: TextStyle(fontFamily: "RobotoRegular"),
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
                              if (signupController.usernameFormKey.currentState!
                                  .validate()) {
                                if (signupController.emailFormKey.currentState!
                                    .validate()) {
                                  if (signupController
                                      .passwordFormKey.currentState!
                                      .validate()) {
                                    if (signupController
                                        .confirmPasswordFormKey.currentState!
                                        .validate()) {
                                      debugPrint("Hello well done");
                                      signupController.signupPersonal();
                                    }
                                  }
                                }
                              }
                            },
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

  // for drawing circle widget
  final Widget circle = Container(
    width: 11.0,
    height: 11.0,
    decoration: const BoxDecoration(
      color: AppColors.green,
      shape: BoxShape.circle,
    ),
    child: Container(),
  );
  // for drawing circle widget
  final Widget circleWhite = Container(
    width: 11.0,
    height: 11.0,
    decoration: const BoxDecoration(
      color: AppColors.white,
      shape: BoxShape.circle,
    ),
    child: Container(),
  );


}

class DrawDottedHorizontalLine extends CustomPainter {
  Paint _paint = Paint();
  DrawDottedHorizontalLine() {
    _paint = Paint();
    _paint.color = Colors.black; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
