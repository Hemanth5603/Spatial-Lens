import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/auth_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/authentication/register.dart';
import 'package:iitt/views/components/error_bottom_sheet.dart';
import 'package:iitt/views/components/success_bottom_sheet.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:permission_handler/permission_handler.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
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
                    child: Text("Reset Password ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontFamily: 'man-r',
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
                                controller: userController.newPassword,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscured,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: InputDecoration(
                                  hintText: "Enter New Password",
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'man-r'),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 5),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscured
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppConstants.customBlue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
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
                            width: w * 0.8,
                            child: Center(
                              child: TextField(
                                controller: userController.confirmPassword,
                                keyboardType: TextInputType.visiblePassword,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Confirm New Password",
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'man-r'),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                    ),
                    onTap: () async {
                      String err = await authController.resetPassword();
                      if (err != "") {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ErrorBottomSheet(
                                error: err,
                              );
                            });
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SuccessBottomSheet(
                                  successMessage:
                                      "Reset Password Successfull, Plese Login in",
                                  buttonText: "Login",
                                  onPressed: () => Get.offAll(const Login(),
                                      transition: Transition.leftToRight,
                                      duration: 300.milliseconds));
                            });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: h * 0.15),
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
