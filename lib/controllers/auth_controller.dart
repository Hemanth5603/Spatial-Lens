import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/user_model.dart';
import 'package:iitt/utils/validate_phone.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  UserModel userModel = UserModel();
  UserController userController = Get.put(UserController());
  Future<String> loginUser() async {
    if (!validatePhoneNumber(userController.phone.text)) {
      return "Invalid Phone Number !";
    }
    if (userController.password.text.isEmpty) {
      return "Password Field is Empty !";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.login}");
    userController.isLoading(true);
    Map<dynamic, String> data = {
      "phone": userController.phone.text,
      "password": userController.password.text,
    };

    var response = await post(uri, body: data);

    if (response.statusCode == 404) {
      return "User Not Found !, Please Sign Up";
    } else if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      userModel = UserModel.fromJson(data);
      prefs.setInt("isLoggedIn", 1);
      prefs.setString("id", userModel.id.toString());
      Get.offAll(const Home(),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
    } else {
      if (kDebugMode) print("Error Logining User");
      return "Incorrect Password !!";
      //Get.snackbar("Error", "Cannot Login, Try Again!!"); // Do something
    }
    userController.isLoading(false);
    return "";
  }

  Future<String> registerUser(String state) async {
    if (userController.firstname.text.isEmpty) {
      return "First Name Field cannot be Empty !";
    }
    if (userController.lasttname.text.isEmpty) {
      return "Last Name Field cannot be Empty !";
    }

    if (userController.password.text.length < 4) {
      return "Password must be of atleast 4 Characters";
    }
    if (userController.city.text.isEmpty) {
      return "City Field Cannot be Empty !";
    }
    if (userController.pincode.text.isEmpty) {
      return "Pincode Field cannot be Empty";
    }
    if (userController.pincode.text.length != 6) {
      return "Invalid Pincode !";
    }
    if (state.isEmpty || state.toString() == "") {
      return "Select Your State !";
    }
    userController.isLoading(true);
    await userController.getCurrentLocation();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.register}");

    Map<String, String> data = {
      "name":
          "${userController.firstname.text} ${userController.lasttname.text}",
      "email": "Default",
      "password": userController.password.text,
      "phone": userController.phone.text,
      "dob": "Default",
      "profileimage": "Default",
      "firstname": userController.firstname.text,
      "lastname": userController.lasttname.text,
      "contributions": 0.toString(),
      "rank": 0.toString(),
      "location": userController.locality.value.toString(),
      "state": state,
      "city": userController.city.text,
      "pincode": userController.pincode.text,
      "occupation": "Default",
    };

    var response = await http.post(
      uri,
      body: data,
    );

    if (response.statusCode == 302) {
      return "User Already Exists !, Please Sign in";
    } else if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body.toString());
      userModel = UserModel.fromJson(responseData);
      prefs.setInt("isLoggedIn", 1);
      prefs.setString("id", userModel.id.toString());
      Get.offAll(const Home(),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
      print(responseData.toString());
    } else {
      if (kDebugMode) print("Error Registering user");
      Get.snackbar("Error", "Cannot Register");
    }
    userController.isLoading(false);
    return "";
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isLoggedIn", 0);
    Get.offAll(const Login(),
        transition: Transition.rightToLeft, duration: 300.milliseconds);
  }
}
