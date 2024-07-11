import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/auth_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/authentication/register.dart';
import 'package:iitt/views/authentication/reset_email_verification.dart';
import 'package:iitt/views/components/error_bottom_sheet.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:permission_handler/permission_handler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());
  bool _isObscured = true;
  String locationErr = "";

  @override
  void initState() {
    super.initState();
    //requestPermissions();
    //userController.getCurrentLocation();
  }

  void requestPermissions() async {
    var status = await Permission.camera.request();
    var mic = await Permission.microphone.request();
    var loc = await Permission.location.request();
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
                    child: Text("Welcome to",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Spatial Lens",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontFamily: 'poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(200, 0, 0, 0))),
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
                            width: w * 0.8,
                            child: Center(
                              child: TextField(
                                controller: userController.password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscured,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: InputDecoration(
                                  hintText: "Password",
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
                  GestureDetector(
                    onTap: () {
                      print("tap");
                      Get.to(ResetEmailVerification(),
                          transition: Transition.rightToLeft,
                          duration: 300.milliseconds);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 12,
                                color: AppConstants.customBlue),
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
                          child: const Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                    ),
                    onTap: () async {
                      String err = await authController.loginUser();
                      if (err != "") {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ErrorBottomSheet(
                                error: err,
                              );
                            });
                        userController.getCurrentLocation();
                        //await Geolocator.requestPermission();
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
