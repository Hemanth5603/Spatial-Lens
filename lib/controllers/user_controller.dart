import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/models/otp_model.dart';
import 'package:iitt/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:iitt/utils/generate_token.dart';
import 'package:iitt/utils/validate_phone.dart';
import 'package:iitt/views/authentication/location.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/home.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  UserModel userModel = UserModel();
  TextEditingController firstname = TextEditingController();
  TextEditingController lasttname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController otp = TextEditingController();

  var isLoading = false.obs;
  double latitude = 0;
  double longitude = 0;
  String address = " ";
  String street = "";
  RxString locality = "".obs;
  RxString country = "".obs;
  String token = "";
  bool isEmailVerified = false;
  String otpRequestID = "";
  OTPModel otpModel = OTPModel();

  @override
  onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Please keep your location enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Location Permission denied!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location Permission denied Forever!');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      print(position.latitude);

      userModel.latitude = position.latitude;
      userModel.longitude = position.longitude;
      latitude = position.latitude;
      longitude = position.longitude;
      address =
          "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}"
              .obs();
      addresss.text =
          "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}"
              .obs();

      street = place.street!;
      locality.value = place.locality ?? "";
      country.value = place.country ?? "";
    } catch (e) {
      print(e);
    }
  }

  // Future<void> googleSignIn() async {
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );

  //   UserCredential response =
  //       await FirebaseAuth.instance.signInWithCredential(credential);

  //   if (response.credential != null) {
  //     Get.offAll(const Home(),
  //         duration: const Duration(milliseconds: 400),
  //         transition: Transition.downToUp);
  //   } else {
  //     Get.snackbar('Error', 'Google sign in error');
  //   }
  // }

  Future<String> sendOTP() async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.sendSms}");
    if (phone.text.isEmpty) {
      return "Please Enter Phone Number to send OTP!";
    }
    token = generateRandomToken();

    final body = {"phone": "91${phone.text}"};

    var response = await http.post(
      uri,
      body: body,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      otpModel = OTPModel.fromJson(data);
      otpRequestID = otpModel.requestId!;
      if (kDebugMode)
        print(
            "${otpModel.requestId}////////////////////////////////////////////////////////////");
      if (kDebugMode)
        print(
            "${otpModel.statusCode}////////////////////////////////////////////////////////////");
      Get.snackbar(
          "OTP Sent Successfully", "OTP has been sent to given phone number",
          margin: const EdgeInsets.all(15),
          backgroundColor: Color.fromARGB(255, 240, 249, 255),
          colorText: AppConstants.customBlue,
          duration: const Duration(seconds: 3));

      if (kDebugMode) print("OTP Sent Successfully");
    } else {
      if (kDebugMode) print("Cannot send OTP ");
    }

    return "";
  }

  Future<String> verifyOTP() async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.verifySms}");
    String err = fieldsValidator();
    if (err != "") {
      return err;
    } else {
      Get.to(const RegisterLocation(),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
    }

    // isLoading(true);
    // print(
    //     "${otpRequestID}////////////////////////////////////////////////////////////");
    // final body = {"request_id": otpRequestID, "otp": otp.text};

    // var response = await http.post(
    //   uri,
    //   body: body,
    // );
    // isLoading(false);
    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body.toString());
    //   otpModel = OTPModel.fromJson(data);
    //   if (otpModel.statusCode == "16") {
    //     return "The entered OTP is incorrect !";
    //   } else if (otpModel.statusCode == "6") {
    //     return "The entered OTP has been expired !, Please resend OTP";
    //   } else if (otpModel.statusCode == "0") {
    //     // Get.snackbar("Verification Successfull",
    //     //     "Your Phone Number has been verified Successfully !!",
    //     //     margin: const EdgeInsets.all(15),
    //     //     backgroundColor: Color.fromARGB(255, 238, 248, 255),
    //     //     colorText: AppConstants.customBlue,
    //     //     duration: const Duration(seconds: 3));
    //     // Future.delayed(1.seconds);
    //     Get.to(const RegisterLocation(),
    //         transition: Transition.rightToLeft, duration: 300.milliseconds);
    //   } else {
    //     print(
    //         "OTP verification failed ///////////////////////////////////////// :: ${otpModel.statusCode}");
    //   }
    // } else {
    //   return "Something Went Wrong ! Try again later";
    // }

    return "";
  }

  Future<bool> updateProfile(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${ApiConstants.baseUrl}${ApiConstants.updateProfile}";
    isLoading(true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = prefs.getString("id")!;
      request.fields['firstname'] = firstname.text;
      request.fields['lastname'] = lasttname.text;
      request.fields['occupation'] = occupation.text;
      request.fields['dob'] = dob.text;
      request.fields['email'] = email.text;
      if (imagePath != "null") {
        request.files
            .add(await http.MultipartFile.fromPath('profileimage', imagePath));
      }

      var res = await request.send();
      isLoading(false);
      if (res.statusCode == 200) {
        if (kDebugMode) print("Profile Update Successfull.....");
        return true;
      } else {
        if (kDebugMode) print("Upload Unsuccessfull");
        return false;
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }

    return true;
  }

  Future<bool> uploadProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${ApiConstants.baseUrl}${ApiConstants.updateProfile}";
    isLoading(true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['id'] = prefs.getString("id")!;

      request.files
          .add(await http.MultipartFile.fromPath('profile_image', imagePath));

      var res = await request.send();
      isLoading(false);
      if (res.statusCode == 200) {
        if (kDebugMode) print("Profile Image Upload Successfull.....");
        return true;
      } else {
        if (kDebugMode) print("Upload Unsuccessfull");
        return false;
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return false;
  }

  String fieldsValidator() {
    if (firstname.text.isEmpty) {
      return "Name Field is Empty !";
    }
    if (lasttname.text.isEmpty) {
      return "Last Name is Empty !";
    }
    if (phone.text.isEmpty) {
      return "Phone Number cannot be empty !";
    }
    if (!validatePhoneNumber(phone.text)) {
      return "Invalid Phone Number";
    }
    if (password.text.length < 8) {
      return "Password must be of atleast 8 Characters";
    }
    return "";
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getUser}");
    isLoading(true);
    String id = prefs.getString("id") ?? "7";

    Map<dynamic, String> data = {
      "id": id,
    };

    var response = await post(uri, body: data);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      userModel = UserModel.fromJson(data);
      firstname.text = userModel.first_name!;
      lasttname.text = userModel.last_name!;
      //email.text = userModel.email!;
      phone.text = userModel.phone!;
    } else {
      if (kDebugMode) print("Error Fetching User Data");
      Get.snackbar("Error", "Cannot Fetch UserData, Try Again!!");
    }
    isLoading(false);
  }
}
