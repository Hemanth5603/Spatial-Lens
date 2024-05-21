import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:iitt/controllers/user_controller.dart';

class ImageController extends GetxController {
  String filePath = "";
  var isLoading = false.obs;

  UserController userController = Get.put(UserController());

  Future<void> uploadData() async {
    String url = "";
    isLoading(true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['latitude'] = userController.userModel.latitude.toString();
      request.fields['longitude'] =
          userController.userModel.longitude.toString();

      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      var res = await request.send();

      if (res.statusCode == 200) {
        if (kDebugMode) print("Data Upload Successfull.....");
      } else {
        if (kDebugMode) print("Upload Unsuccessfull");
      }
    } catch (e) {
      print(e);
    }
    isLoading(false);
  }
}
