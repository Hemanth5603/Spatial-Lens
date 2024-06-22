import 'dart:io';
import 'dart:ui';

import 'package:choice/choice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/components/error_bottom_sheet.dart';
import 'package:iitt/views/components/success_upload_bottomsheet.dart';
import 'package:iitt/views/image_capture.dart';

class ActivityViewer extends StatefulWidget {
  String? imageUrl;
  String? latitude;
  String? longitude;
  String? address;
  String? category;
  String? remarks;
  ActivityViewer(
      {super.key,
      required this.imageUrl,
      required this.category,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.remarks});

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

    UserController userController = Get.put(UserController());
    DataController dataController = Get.put(DataController());

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 241, 247),
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
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: w,
                height: 025,
                child: Text(
                  "Image Information :",
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      margin: EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
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
                      margin: EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
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
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 240, 248, 255),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
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
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                height: 25,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
              Container(
                width: w,
                height: h * 0.25,
              )
            ],
          ),
        ));
  }
}
