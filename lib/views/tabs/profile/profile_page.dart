import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/auth_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/components/warning_bottom_sheet.dart';
import 'package:iitt/views/tabs/profile/edit_profile.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());
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
    //userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 248, 253),
      body: SafeArea(
        child: Obx(() {
          if (userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
            Stack(
              children: [
                _buildProfileImage(),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      //pickImageFromGallery();
                      Get.to(() => const EditProfile(),
                          transition: Transition.rightToLeft,
                          duration: 300.milliseconds);
                    },
                    child: _buildEditIcon(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              userController.userModel.name ?? "User",
              style: const TextStyle(
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios,
                  size: 30, color: Colors.black),
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
          child: Center(
              child: userController.userModel.profile_image == "Default"
                  ? Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: AppConstants.customBlue, width: 4),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person_2_rounded,
                            size: 50,
                            color: Color.fromARGB(255, 204, 220, 255),
                          )),
                    )
                  : Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: AppConstants.customBlue, width: 4),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "${ApiConstants.s3Url}${userController.userModel.profile_image}"),
                        ),
                      ),
                    ))),
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
    return GestureDetector(
      onTap: () {
        //userController.uploadProfileImage(profileImage!);
        setState(() {
          profileImage = "null";
        });
        Get.to(() => const EditProfile(),
            transition: Transition.rightToLeft, duration: 300.milliseconds);
      },
      child: Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _buildProfileTile(Icons.location_pin, "Location",
                    userController.userModel.location!, false),
                _buildProfileTile(
                    Icons.call, "Phone", "${userController.userModel.phone}"),
                _buildProfileTile(Icons.calendar_month, "Date of birth",
                    userController.userModel.dob!, true),
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
      height: 165,
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Settings",
              style: TextStyle(fontFamily: 'poppins', fontSize: 14)),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    authController.logOut();
                  },
                  child: _buildProfileTile(Icons.logout, "Logout", " ", false),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return WarningBottomSheet(
                              successMessage:
                                  "Do you really want to delete your account ?",
                              onPressed: () => authController.deleteAccount(),
                              buttonText: "Delete Account",
                              textColor: AppConstants.customRedLight);
                        });
                  },
                  child: _buildProfileTile(
                      Icons.delete, "Delete Account", " ", true),
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
                  value == "" ? "Update your Profile" : value,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: value == ""
                          ? const Color.fromARGB(255, 206, 206, 206)
                          : Colors.black),
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
