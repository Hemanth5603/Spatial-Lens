import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/image_capture.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserController userController = Get.put(UserController());
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
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: const BoxDecoration(),
              child: Center(
                child: Container(
                  width: w * 0.5,
                  height: h * 0.2,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/icons/iittnif.png'))),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Hi There!",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 45,
                            color: AppConstants.customYellow,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 16,
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
                                controller: userController.name,
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'poppins'),
                                  border: UnderlineInputBorder(
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
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'poppins'),
                                  border: UnderlineInputBorder(
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
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'poppins'),
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontFamily: 'poppins'),
                                  border: UnderlineInputBorder(
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
                                  color: Color.fromARGB(47, 0, 0, 0), width: 2),
                              color: AppConstants.customYellow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                    ),
                    onTap: () async {
                      await userController.registerUser();
                      Get.to(ImageCapture());
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have an account ? ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      GestureDetector(
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Get.off(() => const Login(),
                              transition: Transition.leftToRight,
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
                            style: TextStyle(fontSize: 12, color: Colors.grey))
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
