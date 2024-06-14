import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/home.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  UserModel userModel = UserModel();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();

  var isLoading = false.obs;
  double latitude = 0;
  double longitude = 0;
  String address = " ";
  String street = "";
  RxString locality = "".obs;
  RxString country = "".obs;
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

      //userModel.latitude = position.latitude;
      //userModel.longitude = position.longitude;
      latitude = position.latitude;
      longitude = position.longitude;
      address =
          "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}"
              .obs();
      street = place.street!;
      locality.value = place.locality ?? "";
      country.value = place.country ?? "";
    } catch (e) {
      print(e);
    }
  }

  Future<String> registerUser() async {
    if (name.text.isEmpty) {
      return "Name Field is Empty !";
    }
    if (email.text.isEmpty) {
      return "Email Field cannot be Empty !";
    }
    if (!validateEmail(email.text)) {
      return "Invalid Email Address !";
    }
    if (!validatePhoneNumber(phone.text)) {
      return "Invalid Phone Number";
    }
    if (dob.text.isEmpty) {
      return "Date of Birth cannot be Empty !";
    }
    if (password.text.length < 4) {
      return "Password must be of atleast 4 Characters";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse("http://13.60.93.136:8080/iitt/register");
    isLoading(true);

    Map<dynamic, String> data = {
      "name": name.text,
      "email": email.text,
      "password": password.text,
      "phone": phone.text,
      "dob": dob.text,
      "contributions": 0.toString(),
      "rank": 0.toString(),
      "location": locality.value.toString(),
      "profile_image": "default"
    };

    var response = await post(uri, body: data);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      userModel = UserModel.fromJson(data);
      prefs.setInt("isLoggedIn", 1);
      prefs.setString("id", userModel.id.toString());
      Get.to(const Home(),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
      print(data.toString());
    } else {
      if (kDebugMode) print("Error Registering user");
      Get.snackbar("Error", "Cannot Register");
    }
    isLoading(false);
    return "";
  }

  Future<String> loginUser() async {
    if (!validateEmail(email.text)) {
      return "Invalid Email Address";
    }
    if (password.text.isEmpty) {
      return "Password Field is Empty !";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse("http://13.60.93.136:8080/iitt/login");
    isLoading(true);
    Map<dynamic, String> data = {
      "email": email.text,
      "password": password.text,
    };

    var response = await post(uri, body: data);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      userModel = UserModel.fromJson(data);
      prefs.setInt("isLoggedIn", 1);
      prefs.setString("id", userModel.id.toString());
      Get.to(const Home(),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
    } else {
      if (kDebugMode) print("Error Logining User");
      Get.snackbar("Error", "Cannot Login, Try Again!!");
    }
    isLoading(false);
    return "";
  }

  Future<bool> uploadProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${ApiConstants.baseUrl}${ApiConstants.uploadProfile}";
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
      print(data.toString());
    } else {
      if (kDebugMode) print("Error Fetching User Data");
      Get.snackbar("Error", "Cannot Fetch UserData, Try Again!!");
    }
    isLoading(false);
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isLoggedIn", 0);
    Get.offAll(const Login(),
        transition: Transition.rightToLeft, duration: 300.milliseconds);
  }
}

bool validatePhoneNumber(String phoneNumber) {
  if (phoneNumber.length != 10) {
    return false;
  }
  for (int i = 3; i < phoneNumber.length; i++) {
    if (!phoneNumber[i].contains(RegExp(r'[0-9]'))) {
      return false;
    }
  }
  return true;
}

bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  }

  List<String> parts = email.split("@");
  if (parts.length != 2) {
    return false;
  }

  String username = parts[0];
  String domain = parts[1];

  if (username.isEmpty || domain.isEmpty) {
    return false;
  }

  if (!domain.contains(".") || domain.indexOf(".") <= 0) {
    return false;
  }

  if (domain.contains("..")) {
    return false;
  }

  List<String> domainParts = domain.split(".");
  String tld = domainParts.last;
  if (tld.length < 2 || tld.length > 6) {
    return false;
  }

  RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9._-]+$');
  if (!usernameRegex.hasMatch(username)) {
    return false;
  }

  return true;
}
