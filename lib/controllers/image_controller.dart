import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iitt/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageController extends GetxController {
  String filePath = "";
  var isLoading = false.obs;

  UserController userController = Get.put(UserController());

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

      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      var res = await request.send();
      isLoading(false);
      if (res.statusCode == 200) {
        if (kDebugMode) print("Data Upload Successfull.....");
        return true;
      } else {
        if (kDebugMode) print("Upload Unsuccessfull");
        print(res.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
