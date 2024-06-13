import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Camera extends GetxController {
  late CameraDescription cameraDescription;
  late CameraController cameraController;
  String capturedImage = "";
  bool show = false;

  var isCameraInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  @override
  void onClose() {
    if (isCameraInitialized.value) {
      cameraController.dispose();
    }
    super.onClose();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      var status = await Permission.camera.request();
      if (status.isGranted) {
        final cameras = await availableCameras();
        cameraDescription = cameras.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back,
        );
        cameraController =
            CameraController(cameraDescription, ResolutionPreset.high);

        await cameraController.initialize();

        if (Get.isRegistered<CameraController>()) {
          if (cameraController.value.isInitialized) {
            isCameraInitialized.value = true;
          }
        }
        print(
            "${(cameraController.value.previewSize!.width / 3.3).toString()}");
        print((cameraController.value.previewSize!.height).toString());
      } else {
        print("Camera permission denied");
      }
    } on CameraException catch (e) {
      print('CameraException: ${e.code}\n${e.description}');
    }
  }
}
