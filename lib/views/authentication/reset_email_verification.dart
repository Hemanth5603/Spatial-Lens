import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/auth_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/utils/validate_email.dart';
import 'package:iitt/views/authentication/register.dart';
import 'package:iitt/views/authentication/reset_password.dart';
import 'package:iitt/views/components/error_bottom_sheet.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:permission_handler/permission_handler.dart';

class ResetEmailVerification extends StatefulWidget {
  const ResetEmailVerification({super.key});

  @override
  State<ResetEmailVerification> createState() => ResetEmailVerificationState();
}

class ResetEmailVerificationState extends State<ResetEmailVerification> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());

  int timerSeconds = 90; // Initial timer value
  bool resendOtp = false;
  Timer? _timer;
  bool _isObscured = true;

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timerSeconds > 0) {
          this.timerSeconds--;
        } else {
          _timer!.cancel();
          timerSeconds = 90;
          AuthController().handleExpiredOTP();
          resendOtp = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void requestPermissions() async {
    var status = await Permission.camera.request();
    var mic = await Permission.microphone.request();
  }

  String validator() {
    if (userController.email.text.isEmpty) {
      return "Please Enter Email Address to send OTP !";
    }
    if (!validateEmail(userController.email.text)) {
      return "Invalid Email Address !";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(
          255, 255, 255, 255), // Change the color to your desired color
      statusBarIconBrightness:
          Brightness.dark, // Change the brightness of icons
    ));
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: BoxDecoration(),
              child: Center(
                child: Container(
                  width: w * 0.6,
                  height: h * 0.2,
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/icons/iittnmicps.png'))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Verify Your Email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontFamily: 'poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(183, 0, 0, 0))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: w,
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: h * 0.12,
                            width: w * 0.8,
                            child: Center(
                              child: TextField(
                                controller: userController.email,
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'man-r'),
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 106, 106, 106),
                                    fontFamily: 'man-r',
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: w,
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: h * 0.12,
                            width: w * 0.52,
                            child: Center(
                              child: TextField(
                                controller: userController.otp,
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: const InputDecoration(
                                  hintText: "Enter OTP",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'man-r',
                                      fontSize: 14),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String err = validator();
                              if (err != "") {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ErrorBottomSheet(
                                        error: err,
                                      );
                                    });
                              } else {
                                if (!resendOtp) {
                                  authController
                                      .resetPasswordEmailVerification();
                                }
                                startTimer();
                                setState(() {
                                  resendOtp = true;
                                });
                              }
                            },
                            child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: resendOtp
                                        ? Color.fromARGB(255, 247, 250, 255)
                                        : AppConstants.customBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    resendOtp
                                        ? "Resend OTP \n $timerSeconds"
                                        : "Send OTP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'man-r',
                                      fontSize: 11,
                                      color: resendOtp
                                          ? AppConstants.customBlue
                                          : Colors.white,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          height: 50,
                          width: w * 0.89,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(22, 0, 0, 0), width: 2),
                              color: AppConstants.customBlue,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "Verify OTP",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                    ),
                    onTap: () async {
                      String err = await authController.verifyEmailOTP();
                      if (err != "") {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ErrorBottomSheet(
                                error: err,
                              );
                            });
                      } else {
                        Get.to(const ResetPassword(),
                            transition: Transition.rightToLeft,
                            duration: 300.milliseconds);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have an Account ? ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.customBlue),
                        ),
                        onTap: () {
                          Get.off(() => const Register(),
                              transition: Transition.rightToLeft,
                              duration: 300.milliseconds);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: h * 0.22),
                  Container(
                    margin: const EdgeInsets.only(left: 80),
                    child: const Column(
                      children: [
                        Text(
                          "By Continuing you agree ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Terms of Service   Privacy Policy ",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'poppins'))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

Widget customTextField(w, h, maxLines, keyboardType, hint) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.09, vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const []),
          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 13, 8, 8),
              hintText: hint,
              enabledBorder: getBorder(),
              focusedBorder: getBorder(),
              focusColor: Colors.black,
              prefixStyle: const TextStyle(color: Colors.black),
              hintStyle: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  color: Color.fromARGB(255, 76, 76, 76)),
              //prefixIcon: Icon(Icons.no,color: Color.fromARGB(200, 0, 44, 107)),
            ),
            maxLines: maxLines,
            keyboardType: keyboardType,
          ),
        ),
      ],
    ),
  );
}

OutlineInputBorder getBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(width: 1.5, color: Color.fromARGB(255, 204, 32, 46)),
    gapPadding: 2,
  );
}
