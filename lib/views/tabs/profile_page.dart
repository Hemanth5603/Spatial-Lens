import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());
  String? profileImage = "null";

  void pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage?.path != null) {
        setState(() {
          profileImage = pickedImage!.path;
        });
      }
    } catch (e) {
      // Log or handle error
    }
  }

  @override
  void initState() {
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 248, 253),
      body: SafeArea(
        child: Obx(() {
          if (userController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildUserStats(),
                _buildPersonalInformation(),
                _buildSettings(),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: _buildBottomUpdateProfileButton(),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBackButton(),
            Stack(
              children: [
                _buildProfileImage(),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: _buildEditIcon(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              userController.userModel.name ?? "User",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 160,
      height: 160,
      child: Center(
        child: profileImage == "null"
            ? Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppConstants.customBlue, width: 4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: userController.userModel.profile_image == "Default"
                        ? NetworkImage(
                            "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg")
                        : NetworkImage(
                            "${ApiConstants.s3Url}${userController.userModel.profile_image}"),
                  ),
                ),
              )
            : Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppConstants.customBlue, width: 4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(profileImage!)),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildEditIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppConstants.customBlue,
      ),
      child: Center(
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }

  Widget _buildBottomUpdateProfileButton() {
    return profileImage == "null"
        ? Container(height: 0, width: 0)
        : GestureDetector(
            onTap: () {
              userController.uploadProfileImage(profileImage!);
              setState(() {
                profileImage = "null";
              });
            },
            child: Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppConstants.customBlue,
              ),
              child: Center(
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                      fontFamily: 'man-r', fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          );
  }

  Widget _buildUserStats() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildContributionCard(),
          _buildRankCard(),
        ],
      ),
    );
  }

  Widget _buildContributionCard() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(101, 207, 207, 207), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userController.userModel.contributions.toString(),
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total Contributions", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard() {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(101, 207, 207, 207), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userController.userModel.rank.toString(),
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Rank", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInformation() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Information",
            style: TextStyle(fontFamily: 'poppins', fontSize: 14),
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 220,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: Color.fromARGB(218, 211, 211, 211)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(54, 207, 207, 207), blurRadius: 20),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                _buildProfileTile(Icons.email_outlined, "Email",
                    userController.userModel.email!),
                _buildProfileTile(Icons.call, "Phone",
                    "+91 ${userController.userModel.phone}"),
                _buildProfileTile(Icons.calendar_month, "Date of birth",
                    userController.userModel.dob!),
                _buildProfileTile(Icons.location_pin, "Location",
                    userController.userModel.location!, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 115,
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Settings",
              style: TextStyle(fontFamily: 'poppins', fontSize: 14)),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                  color: Color.fromARGB(169, 201, 201, 201), width: 1),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(54, 207, 207, 207), blurRadius: 20),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    userController.logOut();
                  },
                  child: _buildProfileTile(Icons.logout, "Logout", "", true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String value,
      [bool lastTile = false]) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 233, 236, 255),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Color.fromARGB(255, 117, 117, 117),
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  value,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (!lastTile)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color.fromARGB(190, 224, 224, 224),
            ),
        ],
      ),
    );
  }
}
