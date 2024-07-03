import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iitt/controllers/camera_controller.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/image_viewer.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageCapture extends StatefulWidget {
  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  String capturedImage = "";
  bool show = true;
  DataController dataController = Get.put(DataController());
  UserController userController = Get.put(UserController());
  final Camera camera = Get.put(Camera());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          show == false
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: h * 0.8,
                  color: Colors.black,
                )
              : Expanded(
                  child: GestureDetector(
                      onScaleUpdate: (details) {
                        double newZoomLevel = camera.zoomLevel.value *
                            (1 + (details.scale - 1) * 0.07);
                        newZoomLevel = newZoomLevel.clamp(
                          camera.minZoomLevel.value,
                          camera.maxZoomLevel.value,
                        );
                        camera.setZoom(newZoomLevel);
                      },
                      child: CameraPreview(camera.cameraController)),
                ),
          GestureDetector(
            onTap: () {
              _takePicture(camera);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: h * 0.2,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _takePicture(Camera camera) async {
    try {
      XFile file = await camera.cameraController.takePicture();
      capturedImage = file.path;
      dataController.filePath = file.path;

      // Save the image to the gallery
      final Uint8List imageData = await file.readAsBytes();
      final result = await ImageGallerySaver.saveImage(imageData,
          quality: 80, name: basename(file.path));
      print("Save result: $result");

      userController.getCurrentLocation();
      Get.to(
        ImageViewer(path: capturedImage),
        transition: Transition.rightToLeft,
        duration: 300.milliseconds,
      );
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }
}
