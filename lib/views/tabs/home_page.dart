import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/image_capture.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Hi There ! 👋",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 40,
                              color: AppConstants.customRed,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: AppConstants.customRed,
                              size: 20,
                            ),
                            Obx(() => Text(
                                  " ${userController.locality.value} ${userController.country.value}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppConstants.customRedLight),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ImageCapture(),
                    transition: Transition.rightToLeft,
                    duration: 300.milliseconds);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppConstants.customRedLight2,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Text(
                        "Upload Geo-Spatial Data 🗺️",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppConstants.customRed,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Open Camera",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              color: AppConstants.customRedLight),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 20, color: AppConstants.customRedLight)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
