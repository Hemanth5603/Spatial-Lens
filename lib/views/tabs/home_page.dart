import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/camera_controller.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/activity_model.dart';
import 'package:iitt/models/leaderboard_model.dart';
import 'package:iitt/views/components/activity_card.dart';
import 'package:iitt/views/components/circular_camera_preview.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:iitt/views/leaderboard.dart';
import 'package:iitt/views/tabs/profile/profile_page.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

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
    userController.getCurrentLocation();
    userController.getUser();
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
        child: CustomRefreshIndicator(
          onRefresh: () async {
            // Refresh logic here
            await dataController.getActivity();
          },
          builder: (BuildContext context, Widget child,
              IndicatorController controller) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (controller.isDragging || controller.isArmed)
                  const Positioned(
                    top: 35.0,
                    child: Icon(
                      Icons.refresh,
                      color: Colors.blue,
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, controller.value * 100),
                  child: child,
                ),
              ],
            );
          },
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
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            height: 440,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Text(
                                                  userController.userModel
                                                              .first_name ==
                                                          null
                                                      ? "Hi ! 👋"
                                                      : "Hi ${userController.userModel.first_name} ! 👋",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
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
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
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
                                                blurRadius: 20,
                                              ),
                                            ],
                                          ),
                                          child: show == false
                                              ? Container(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      180),
                                                          color: const Color
                                                              .fromARGB(141,
                                                              131, 131, 131),
                                                        ),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(ImageCapture(),
                                              transition:
                                                  Transition.rightToLeft,
                                              duration: 300.milliseconds);
                                        },
                                        child: Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              color: Colors.white,
                                            ),
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
                                                      color: AppConstants
                                                          .customBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color:
                                                        AppConstants.customBlue,
                                                  ),
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
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: const Text(
                          "Your Activity",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'man-r',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Obx(
              () => dataController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : dataController.activityModel.data?.length == 0
                      ? Center(
                          child: Text(
                          "No Activity Yet !",
                          style: TextStyle(fontFamily: 'man-r', fontSize: 16),
                        ))
                      : ListView.builder(
                          itemCount: dataController.activityModel.data?.length,
                          shrinkWrap: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return activityCard(
                              index: index,
                              imageUrl: dataController
                                  .activityModel.data?[index].Image,
                              category: dataController
                                  .activityModel.data?[index].Category,
                              latitude: dataController
                                  .activityModel.data?[index].Latitude
                                  .toString(),
                              longitude: dataController
                                  .activityModel.data?[index].Longitude
                                  .toString(),
                              remarks: dataController
                                  .activityModel.data?[index].Remarks,
                              address: dataController
                                      .activityModel.data?[index].address ??
                                  "Deafult Address",
                              date: dataController
                                  .activityModel.data?[index].date,
                              time: dataController
                                  .activityModel.data?[index].time,
                              isApproved: dataController
                                      .activityModel.data?[index].isApproved ??
                                  0,
                              dataId: dataController
                                  .activityModel.data?[index].dataId,
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
