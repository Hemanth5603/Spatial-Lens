import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:iitt/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  UserModel userModel = UserModel();
  TextEditingController name = TextEditingController();

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
      //userModel.address ="${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
      // =  "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerUser() async {
    final uri = Uri.parse("localhost:3000/iitt/register");

    Map<dynamic, String> data = {
      "name": name.text,
    };

    var response = await post(uri, body: data);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
    }
  }
}
