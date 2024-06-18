import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/activity_model.dart';
import 'package:iitt/models/leaderboard_model.dart';
import 'package:iitt/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  void onInit() {
    super.onInit();
    getActivity();
  }

  String filePath = "";
  var isLoading = false.obs;
  TextEditingController remarks = TextEditingController();
  UserController userController = Get.put(UserController());
  ActivityModel activityModel = ActivityModel();
  LeaderboardModel leaderboardModel = LeaderboardModel();

  Future<String> uploadData(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "http://13.60.93.136:8080/uploadImage";
    if (category == "Default") {
      return "Select Category";
    }
    isLoading(true);
    try {
      print(category);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['latitude'] = userController.latitude.toString();
      request.fields['longitude'] = userController.longitude.toString();
      request.fields['id'] = prefs.getString("id")!;
      request.fields['category'] = category;
      request.fields['remarks'] = remarks.text.toString();
      request.fields['address'] = userController.addresss.toString();

      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      var res = await request.send();
      isLoading(false);
      if (res.statusCode == 200) {
        if (kDebugMode) print("Data Upload Successfull.....");
        return "";
      } else {
        if (kDebugMode) print("Upload Unsuccessfull");
        return "Something Went Wrong !";
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return "";
  }

  Future<void> getActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = "${ApiConstants.baseUrl} ${ApiConstants.getActivity}$id";
    print(url);
    isLoading(true);
    var response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      activityModel = ActivityModel.fromJson(data);

      print(data.toString());
    } else {
      if (kDebugMode) print("Error fetcing activity data");
      Get.snackbar("Error", "Cannot fetch data");
    }
    isLoading(false);
  }

  Future<void> getLeaderBoard(limit, category) async {
    int limitValue = 0;

    switch (limit) {
      case 'Top 5':
        limitValue = 5;
        break;
      case 'Top 10':
        limitValue = 10;
        break;
      case 'Top 20':
        limitValue = 20;
        break;
      default:
        limitValue = 0;
        break;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${ApiConstants.baseUrl}${ApiConstants.getLeaderBoard}";
    print(url);
    final body = {
      "limit": limitValue.toString(),
      "category": category ?? "Default"
    };
    isLoading(true);
    var response = await post(Uri.parse(url), body: body);

    userController.userModel.id = int.parse(prefs.getString("id")!);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      leaderboardModel = LeaderboardModel.fromJson(data);

      print(data.toString());
    } else {
      if (kDebugMode) print("Error Fetching LeaderBoard");
      Get.snackbar("Error", "Cannot fetch LeaderBoard");
    }
    isLoading(false);
  }
}
