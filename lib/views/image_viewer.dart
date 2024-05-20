import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/controllers/user_controller.dart';

class ImageViewer extends StatefulWidget {
  String path;
  ImageViewer({
    super.key,
    required this.path,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    List<String> items = ["Agriculture", "Building", "Forest", "Water Bodies"];
    String? selectedItem;

    UserController userController = Get.put(UserController());
    return Scaffold(
      bottomNavigationBar: Container(
        width: w,
        height: h * 0.07,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: const Center(
          child: Text(
            "Confirm Image",
            style: TextStyle(
                fontFamily: 'man-r',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      appBar: AppBar(
          title: const Text(
        'Confirm Image',
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'man-sb',
          color: Colors.black,
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.6,
              child: Image.file(
                alignment: Alignment.topLeft,
                File(widget.path),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: w,
              height: h * 0.06,
              child: const Text(
                "Image Information",
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: w,
              height: h * 0.05,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latitude : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userController.userModel.latitude.toString(),
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: h * 0.05,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Longitude : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userController.userModel.longitude.toString(),
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: w,
                height: h * 0.08,
                child: Center(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      "Select Image Type",
                      style: TextStyle(fontFamily: 'poppins', fontSize: 10),
                    ),
                    value: selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
