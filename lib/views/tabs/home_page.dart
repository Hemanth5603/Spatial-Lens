import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/camera_controller.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/leaderboard_model.dart';
import 'package:iitt/views/components/activity_card.dart';
import 'package:iitt/views/components/circular_camera_preview.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:iitt/views/leaderboard.dart';
import 'package:iitt/views/tabs/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool show = false;

  DataController dataController = Get.put(DataController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          show = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Camera camera = Get.put(Camera());
    return Scaffold(
        body: DefaultTabController(
      length: 1,
      child: NestedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 510,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 0, 86, 224),
                              Colors.white
                            ])),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            "Hi There ! 👋",
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Obx(() => Text(
                                                    " ${userController.locality.value} ${userController.country.value}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              Get.to(ProfilePage(),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  duration: 300.milliseconds);
                                            },
                                            icon: const Icon(
                                              Icons.person_outline_rounded,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                    child: Container(
                                        width: 220,
                                        height: 220,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 5),
                                            borderRadius:
                                                BorderRadius.circular(120),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      94, 182, 223, 255),
                                                  blurRadius: 20)
                                            ]),
                                        child: show == false
                                            ? Container(
                                                child: Center(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: const Icon(
                                                      Icons.camera_alt_rounded,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  Get.to(ImageCapture());
                                                },
                                                child: Stack(
                                                  children: [
                                                    CircularCameraPreview(
                                                        controller: camera
                                                            .cameraController),
                                                    Container(
                                                      width: 220,
                                                      height: 220,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      180),
                                                          color: const Color
                                                              .fromARGB(141,
                                                              131, 131, 131)),
                                                      child: Center(
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: const Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(ImageCapture(),
                                          transition: Transition.rightToLeft,
                                          duration: 300.milliseconds);
                                    },
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(45),
                                            color: Colors.white),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Open Camera",
                                                style: TextStyle(
                                                    fontFamily: 'man-r',
                                                    fontSize: 12,
                                                    color:
                                                        AppConstants.customBlue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 15,
                                                color: AppConstants.customBlue,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const LeaderboardPage(),
                            transition: Transition.rightToLeft,
                            duration: 300.milliseconds);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        margin: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 227, 243, 255),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 15,
                              child: SizedBox(
                                height: 100,
                                child: Text(
                                  "Find Where You Rank !",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppConstants.customBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 15,
                              child: Text(
                                "Leaderboard",
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 14,
                                    color: AppConstants.customBlue),
                              ),
                            ),
                            Positioned(
                                right: -20,
                                bottom: -20,
                                child: Transform.rotate(
                                  angle: -95.05,
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            colorFilter:
                                                ColorFilter.linearToSrgbGamma(),
                                            image: AssetImage(
                                              "assets/icons/podium.png",
                                            ))),
                                  ),
                                ))
                          ],
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: const Text(
                      "Your Activity",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'man-r'),
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: Obx(
          () => dataController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: dataController.activityModel.data
                      ?.length, // Replace with your dynamic item count
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return activityCard(
                      index: index,
                      imageUrl: dataController.activityModel.data?[index].Image,
                      category:
                          dataController.activityModel.data?[index].Category,
                      latitude: dataController
                          .activityModel.data?[index].Latitude
                          .toString(),
                      longitude: dataController
                          .activityModel.data?[index].Longitude
                          .toString(),
                      remarks:
                          dataController.activityModel.data?[index].Remarks,
                    );
                  },
                ),
        ),
      ),
    ));
  }
}
