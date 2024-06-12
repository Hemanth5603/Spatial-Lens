import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/models/activity_model.dart';
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

  Future<bool> uploadData(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "http://13.60.93.136:8080/uploadImage";
    isLoading(true);
    try {
      print(category);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['latitude'] = userController.latitude.toString();
      request.fields['longitude'] = userController.longitude.toString();
      request.fields['id'] = prefs.getString("id")!;
      request.fields['category'] = category;
      request.fields['remarks'] = remarks.text.toString();

      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      var res = await request.send();
      isLoading(false);
      if (res.statusCode == 200) {
        if (kDebugMode) print("Data Upload Successfull.....");
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
}
