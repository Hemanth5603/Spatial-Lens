import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/user_model.dart';
import 'package:iitt/utils/generate_token.dart';
import 'package:iitt/utils/validate_email.dart';

import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  UserModel userModel = UserModel();
  UserController userController = Get.put(UserController());
  var token = "";

  Future<String> loginUser() async {
    if (userController.email.text.isEmpty) {
      return "Email Cannot be empty !";
    }
    if (!validateEmail(userController.email.text)) {
      return "Invalid Email Address !";
    }
    // if (!validatePhoneNumber(userController.phone.text)) {
    //   return "Invalid Phone Number !";
    // }
    if (userController.password.text.isEmpty) {
      return "Password Field is Empty !";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.login}");
    userController.isLoading(true);
    Map<dynamic, String> data = {
      "email": userController.email.text,
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

  Future<String> sendEmailOTP() async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.sendEmail}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String err = userController.fieldsValidator();
    if (err != "") return err;
    token = generateRandomToken();
    prefs.setString("token", token);

    final body = {"to": userController.email.text, "token": token};

    var response = await http.post(
      uri,
      body: body,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (kDebugMode) print(data.toString());

      Get.snackbar(
          "OTP Sent Successfully", "Please check your Email Inbox for OTP Code",
          margin: const EdgeInsets.all(15),
          backgroundColor: const Color.fromARGB(255, 240, 249, 255),
          colorText: AppConstants.customBlue,
          duration: const Duration(seconds: 4));

      if (kDebugMode) print("OTP Sent Successfully");
    } else {
      if (kDebugMode) print("Cannot send OTP ");
      return "Something Went Wrong! Please Try Again";
    }
    return "";
  }

  Future<String> verifyEmailOTP() async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.verifyOtp}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsToken = prefs.getString("token")!;
    if (userController.email.text.isEmpty) {
      return "Please Enter Email Address to send OTP !";
    }
    if (!validateEmail(userController.email.text)) {
      return "Invalid Email Address !";
    }
    if (userController.otp.text.isEmpty) {
      return "Please Enter OTP to verify email address !";
    }
    userController.isLoading(true);

    final body = {"token": prefsToken, "otp": userController.otp.text};

    var response = await http.post(
      uri,
      body: body,
    );
    userController.isLoading(false);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {
      return "Entered OTP is Incorrect !";
    } else if (response.statusCode == 404) {
      return "Entered OTP has Expired !";
    }
    return "";
  }

  Future<String> handleExpiredOTP() async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expiredOtp}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsToken = prefs.getString("token")!;

    final body = {"token": prefsToken};

    var response = await http.delete(
      uri,
      body: body,
    );
    if (response.statusCode == 200) {
      if (kDebugMode) print("Handled Expired OTP Successfully");
    } else {
      if (kDebugMode) print("Cannot handle Expired OTP");
      return "Something Went Wrong! Please Try Again";
    }
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
      "email": userController.email.text,
      "password": userController.password.text,
      "phone": "",
      "dob": "",
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
    } else {
      if (kDebugMode) print("Error Registering user");
      Get.snackbar("Error", "Cannot Register");
    }
    userController.isLoading(false);
    return "";
  }

  Future<String> resetPasswordEmailVerification() async {
    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.resetPasswordEmail}");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = generateRandomToken();
    prefs.setString("token", token);

    final body = {"to": userController.email.text, "token": token};

    var response = await http.post(
      uri,
      body: body,
    );
    if (response.statusCode == 200) {
      Get.snackbar(
          "OTP Sent Successfully", "Please check your Email Inbox for OTP Code",
          margin: const EdgeInsets.all(15),
          backgroundColor: const Color.fromARGB(255, 240, 249, 255),
          colorText: AppConstants.customBlue,
          duration: const Duration(seconds: 4));

      if (kDebugMode) print("OTP Sent Successfully");
    } else if (response.statusCode == 404) {
      return "User Not found with respective email, Please Sign Up !";
    } else {
      if (kDebugMode) print("Cannot send OTP ");
      return "Something Went Wrong! Please Try Again";
    }
    return "";
  }

  Future<String> resetPassword() async {
    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.resetPassword}");
    if (userController.newPassword.text.isEmpty) {
      return "The New Password field cannot be empty !";
    }
    if (userController.confirmPassword.text.isEmpty) {
      return "The Confirm Password field cannot be empty !";
    }
    if (userController.newPassword.text.length < 8) {
      return "Password must be of atleast 8 Characters";
    }

    if (userController.newPassword.text !=
        userController.confirmPassword.text) {
      return "The entered password does not match each other !";
    }

    final body = {
      "email": userController.email.text,
      "password": userController.confirmPassword.text
    };

    var response = await http.post(
      uri,
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      return "Something Went Wrong! Please Try Again";
    }
    return "";
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isLoggedIn", 0);
    Get.offAll(const Login(),
        transition: Transition.rightToLeft, duration: 300.milliseconds);
  }
}
