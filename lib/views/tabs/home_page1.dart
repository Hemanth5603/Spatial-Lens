import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/camera_controller.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/components/activity_card.dart';
import 'package:iitt/views/image_capture.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  UserController userController = Get.put(UserController());
  DataController dataController = Get.put(DataController());
  late CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(21.7845737, 77.921099), zoom: 10);
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? customDataIcon;

  @override
  void initState() {
    super.initState();
    //userController.getCurrentLocation();
    userController.getUser();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {});
      }
    });
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    final Uint8List dataIcon =
        await getBytesFromAsset("assets/icons/pin4.png", 30);
    setState(() {
      customDataIcon = BitmapDescriptor.bytes(dataIcon);
    });
  }

  Set<Marker> _createMarkers() {
    final markers = <Marker>{};
    if (dataController.activityModel.data!.isNotEmpty) {
      print(
          "latitude : ------------------------------- ${userController.latitude}");

      for (var activity in dataController.activityModel.data!) {
        final marker = Marker(
            markerId: MarkerId(activity.dataId.toString()),
            position: LatLng(activity.Latitude!, activity.Longitude!),
            infoWindow: InfoWindow(
              title: activity.Category,
              snippet: activity.Remarks,
            ),
            icon: customDataIcon ?? BitmapDescriptor.defaultMarker);
        markers.add(marker);
      }
    }
    return markers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final Camera camera = Get.put(Camera());
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Obx(() {
                  if (userController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataController.activityModel.data!.isNotEmpty) {
                      _cameraPosition = CameraPosition(
                          target: LatLng(
                              dataController
                                  .activityModel
                                  .data![dataController
                                          .activityModel.data!.length -
                                      1]
                                  .Latitude!,
                              dataController
                                  .activityModel
                                  .data![dataController
                                          .activityModel.data!.length -
                                      1]
                                  .Longitude!),
                          zoom: 14.5);
                    }

                    return GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      mapType: MapType.hybrid,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: _createMarkers(),
                    );
                  }
                }),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: AppConstants.customBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        // userController.userModel.first_name == null
                        //     ? "Hi ! 👋"
                        //     : "Hi ${userController.userModel.first_name} ! 👋",
                        "Spatial Lens",
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 25,
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
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.55,
                left: MediaQuery.of(context).size.width / 3.5,
                child: GestureDetector(
                  onTap: () {
                    Get.to(ImageCapture(),
                        transition: Transition.rightToLeft,
                        duration: 300.milliseconds);
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload Data",
                              style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 12,
                                color: AppConstants.customBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: AppConstants.customBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SlidingBox(
                  collapsed: true,
                  minHeight: 150,
                  maxHeight: 600,
                  color: Colors.white,
                  animationCurve: Curves.ease,
                  animationDuration: 300.milliseconds,
                  draggableIconBackColor: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  body: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        padding: EdgeInsets.all(15),
                        child: const Text(
                          "Your Activity",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'man-r',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 650,
                        child: Obx(
                          () => dataController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : dataController.activityModel.data?.length == 0
                                  ? Center(
                                      child: Text(
                                      "No Activity Yet !",
                                      style: TextStyle(
                                          fontFamily: 'man-r', fontSize: 16),
                                    ))
                                  : ListView.builder(
                                      itemCount: dataController
                                          .activityModel.data?.length,
                                      shrinkWrap: false,
                                      itemBuilder: (context, index) {
                                        return activityCard(
                                          index: index,
                                          imageUrl: dataController
                                              .activityModel.data?[index].Image,
                                          category: dataController.activityModel
                                              .data?[index].Category,
                                          latitude: dataController.activityModel
                                              .data?[index].Latitude
                                              .toString(),
                                          longitude: dataController
                                              .activityModel
                                              .data?[index]
                                              .Longitude
                                              .toString(),
                                          remarks: dataController.activityModel
                                              .data?[index].Remarks,
                                          address: dataController.activityModel
                                                  .data?[index].address ??
                                              "Deafult Address",
                                          date: dataController
                                              .activityModel.data?[index].date,
                                          time: dataController
                                              .activityModel.data?[index].time,
                                          isApproved: dataController
                                                  .activityModel
                                                  .data?[index]
                                                  .isApproved ??
                                              0,
                                          dataId: dataController.activityModel
                                              .data?[index].dataId,
                                        );
                                      },
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
