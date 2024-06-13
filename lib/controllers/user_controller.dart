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

  Future<void> registerUser() async {
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
  }

  Future<void> loginUser() async {
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
  }


  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getUser}");
    isLoading(true);
    String id = prefs.getString("id") ?? "7";

    Map<dynamic, String> data = {
      "id":id,
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
}
