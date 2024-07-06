import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';

import 'package:iitt/views/components/map_viewer.dart';

import 'package:iitt/views/components/warning_bottom_sheet.dart';

class ActivityViewer extends StatefulWidget {
  String? imageUrl;
  String? latitude;
  String? longitude;
  String? address;
  String? category;
  String? remarks;
  String? date;
  String? time;
  int? isApproved;
  int? dataId;
  ActivityViewer(
      {super.key,
      required this.imageUrl,
      required this.category,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.remarks,
      required this.date,
      required this.dataId,
      required this.time,
      required this.isApproved});

  @override
  State<ActivityViewer> createState() => _ActivityViewerState();
}

class _ActivityViewerState extends State<ActivityViewer> {
  String? selectedItem = "Default";
  void setSelectedValue(String? value) {
    setState(() => selectedItem = value);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    DataController dataController = Get.put(DataController());

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 241, 247),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return WarningBottomSheet(
                    successMessage: "Are you sure you want to delete ?",
                    onPressed: () {
                      Get.back();
                      dataController.deleteData(widget.dataId.toString());
                    },
                    buttonText: "Delete",
                    textColor: AppConstants.customRedLight,
                  );
                });
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //color: AppConstants.customRedLight,

                border:
                    Border.all(color: AppConstants.customRedLight, width: 2)),
            child: Center(
                child: Obx(
              () => dataController.isLoading.value
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                  : Text(
                      "Delete",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 18,
                          color: AppConstants.customRed),
                    ),
            )),
          ),
        ),
        appBar: AppBar(
            title: const Text(
          'Your Activity',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
            color: Colors.black,
          ),
        )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: w,
                    height: h * 0.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${ApiConstants.s3Url}${widget.imageUrl}"),
                        fit: BoxFit
                            .cover, // Ensure the image covers the container
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: w,
                height: 025,
                child: const Text(
                  "Image Information :",
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      margin: const EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 240, 248, 255),
                                blurRadius: 10)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.latitude ?? "0.000000",
                            style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.customBlue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Latitude",
                            style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      margin: const EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 240, 248, 255),
                                blurRadius: 10)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.longitude ?? "0.000000",
                            style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.customBlue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Longitude",
                            style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 240, 248, 255),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Address",
                      style: TextStyle(
                        fontFamily: 'man-r',
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.address ?? "Default",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.customBlue),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: MapViewer(
                    latitude: double.parse(widget.latitude!),
                    longitude: double.parse(widget.longitude!)),
              ),
              Container(
                width: w,
                height: 25,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Category :",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  width: widget.category!.length * 12,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Center(
                    child: Text(
                      widget.category ?? "Default",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'poppins',
                        color: AppConstants.customBlue,
                      ),
                    ),
                  )),
              Container(
                width: w,
                height: 20,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: const Text(
                  "Remarks",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: w,
                  height: 100,
                  child: Text(
                    widget.remarks ?? "No Remarks",
                    style: TextStyle(
                        fontFamily: 'man-r',
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        color: AppConstants.customBlue),
                  )),
              SizedBox(
                width: w,
                height: h * 0.25,
              )
            ],
          ),
        ));
  }
}
