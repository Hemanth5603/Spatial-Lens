import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:get/get.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/home.dart';

import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? profileImage = "null";

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage?.path != null) {
      // Compress the image
      XFile? compressedFile = await compressImage(File(pickedImage!.path));

      setState(() {
        profileImage = compressedFile?.path;
      });
    }
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;

    // Get the file extension
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitFilePath = filePath.substring(0, (lastIndex));
    final outPath = "${splitFilePath}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50, // Adjust the quality parameter to reduce the file size
    );

    return result;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        userController.dob.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: Container(
            width: w,
            height: h * 0.08,
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: Container(
                  width: w,
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppConstants.customBlue,
                  ),
                  child: Obx(() => userController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ))
                      : const Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))),
              onTap: () async {
                await userController.updateProfile(profileImage!);
                Get.offAll(const Home(),
                    transition: Transition.leftToRight,
                    duration: 300.milliseconds);
              },
            )),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          title: const Text(
            "Edit Profile",
            style: TextStyle(
                fontFamily: 'poppins', fontSize: 20, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  width: w,
                  height: h * 0.2,
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                            width: w * 0.35,
                            height: w * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: profileImage == "null"
                                ? Center(
                                    child: userController
                                                .userModel.profile_image ==
                                            "Default"
                                        ? Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color:
                                                      AppConstants.customBlue,
                                                  width: 4),
                                            ),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.person_2_rounded,
                                                  size: 50,
                                                  color: Color.fromARGB(
                                                      255, 204, 220, 255),
                                                )),
                                          )
                                        : Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color:
                                                      AppConstants.customBlue,
                                                  width: 4),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${ApiConstants.s3Url}${userController.userModel.profile_image}"),
                                              ),
                                            ),
                                          ))
                                : Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppConstants.customBlue,
                                            width: 4),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image:
                                                FileImage(File(profileImage!)),
                                            fit: BoxFit.cover)),
                                  )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppConstants.customBlue,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          onTap: () {
                            pickImage();
                          },
                        ),
                      )
                    ],
                  )),
              Container(
                width: w,
                height: h * 0.1,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: w * 0.45,
                      child: TextField(
                        controller: userController.firstname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: const TextStyle(
                              fontFamily: 'poppins', fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.customBlue)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.45,
                      child: TextField(
                        controller: userController.lasttname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: const TextStyle(
                              fontFamily: 'poppins', fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.customBlue)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                height: h * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  readOnly: true,
                  controller: userController.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    labelStyle:
                        const TextStyle(fontFamily: 'poppins', fontSize: 14),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.customBlue)),
                  ),
                ),
              ),
              Container(
                width: w,
                height: h * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: userController.phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.customBlue)),
                  ),
                ),
              ),
              Container(
                width: w,
                height: h * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextField(
                              controller: userController.dob,
                              decoration: const InputDecoration(
                                labelText: "Date of Birth",
                                hintText: "Data of birth",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 106, 106, 106),
                                    fontFamily: 'poppins'),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 5),
                                ),
                              ),
                              style: const TextStyle(fontFamily: 'poppins'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                height: h * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: userController.occupation,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Occupation",
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.customBlue)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
