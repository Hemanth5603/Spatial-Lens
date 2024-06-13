import 'dart:io';
import 'dart:ui';

import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
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
      backgroundColor: Color.fromARGB(255, 231, 241, 247),
      
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: w,
                  height: h * 0.7,
                  child: Image.file(
                    alignment: Alignment.topCenter,
                    File(widget.path),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
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
                "Image Information :",
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
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
                          userController.latitude.toString(),
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
                          userController.longitude.toString(),
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
             width: MediaQuery.of (context).size.width,
             margin: EdgeInsets.symmetric(horizontal: 20),
             padding: EdgeInsets.all(15),
             height:80,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Colors.white,
              boxShadow: [
                BoxShadow( 
                  color: Color.fromARGB(255, 240, 248, 255), 
                  blurRadius: 10

                )
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
                          userController.address.toString(),
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
              height: h * 0.04,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Category :",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        color: AppConstants.customBlue,
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
              child: Text(
                "Remarks",
                style: TextStyle(
                    fontSize: 18,
                    color: AppConstants.customBlue,
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
            ),
             GestureDetector(
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
              color: AppConstants.customBlue, borderRadius: BorderRadius.circular(10)),
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
                          color: Color.fromARGB(255, 254, 253, 253),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
          
      ),
          Container(
          width: w,
          height: h * 0.25,
          )  
        ],
      ),
      )
    );
  }
  
}
