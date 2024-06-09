import 'dart:io';

import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/controllers/image_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/image_capture.dart';

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
  List<String> choices = [
    "Agriculture",
    "Building",
    "Forest",
    "Water Bodies",
    "Coastal",
    "Urban"
  ];
  String? selectedItem = "Land";
  void setSelectedValue(String? value) {
    setState(() => selectedItem = value);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    UserController userController = Get.put(UserController());
    ImageController imageController = Get.put(ImageController());
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          bool res = await imageController.uploadData(selectedItem!);
          if (res) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetContent();
                });
          } else {
            Get.snackbar("Error ", 'Could Not Upload Data');
          }
        },
        child: Container(
          width: w,
          height: h * 0.06,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Obx(
            () => imageController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Center(
                    child: Text(
                      "Upload Data",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
            SizedBox(
              height: 15,
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
                    userController.latitude.toString(),
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
                    userController.longitude.toString(),
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
                    "Address : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: w * 0.6,
                    child: Text(
                      userController.address.toString(),
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: h * 0.04,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Category :",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InlineChoice<String>.single(
              clearable: true,
              value: selectedItem,
              onChanged: (String? value) {
                setState(() {
                  selectedItem = value;
                });
              },
              itemCount: choices.length,
              itemBuilder: (state, i) {
                return ChoiceChip(
                  selected: state.selected(choices[i]),
                  onSelected: state.onSelected(choices[i]),
                  label: Text(
                    choices[i],
                    style: TextStyle(fontFamily: 'poppins'),
                  ),
                  selectedColor: Color.fromARGB(
                      255, 136, 255, 156), // Change selected color to red
                  avatar: state.selected(choices[i])
                      ? Icon(Icons.check) // Show check mark if selected
                      : null,
                );
              },
              listBuilder: ChoiceList.createWrapped(
                spacing: 10,
                runSpacing: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
              ),
            ),
            Container(
              width: w,
              height: h * 0.20,
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 300, // Set the height of the bottom sheet
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: w,
            height: h * 0.1,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/check.png"))),
          ),
          SizedBox(height: 20),
          Text(
            'Data Uploaded Successfully ',
            style: TextStyle(fontSize: 20.0, fontFamily: 'poppins'),
          ),
          Spacer(), // Push the bottom container to the bottom
          GestureDetector(
            onTap: () {
              Get.offAll(ImageCapture(),
                  transition: Transition.leftToRight,
                  duration: 300.milliseconds);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Go Back !',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
