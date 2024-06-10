import 'dart:io';

import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/image_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/components/success_upload_bottomsheet.dart';
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
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          bool res = await dataController.uploadData(selectedItem!);
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
            () => dataController.isLoading.value
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
        'Review Data',
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
              height: h * 0.03,
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
              height: h * 0.03,
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
              height: h * 0.04,
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Address : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * 0.6,
                    height: 40,
                    child: Text(
                      userController.address.toString(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                      ),
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
              itemCount: AppConstants.choices.length,
              itemBuilder: (state, i) {
                return ChoiceChip(
                  padding: EdgeInsets.all(3),
                  selected: state.selected(AppConstants.choices[i]),
                  onSelected: state.onSelected(AppConstants.choices[i]),
                  label: Text(
                    AppConstants.choices[i],
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  selectedColor: Color.fromARGB(
                      255, 136, 255, 156), // Change selected color to red
                  avatar: state.selected(AppConstants.choices[i])
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
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: const Text(
                "Remarks",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: w,
              height: 100,
              child: TextField(
                controller: dataController.remarks,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(fontFamily: 'poppins', fontSize: 14),
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "Add Comment on data....",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 106, 106, 106),
                      fontFamily: 'poppins',
                      fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
