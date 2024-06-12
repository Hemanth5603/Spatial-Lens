import 'package:flutter/widgets.dart';
import 'package:iitt/controllers/camera_controller.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/image_viewer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCapture extends StatefulWidget {
  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  // late CameraController controller;
  // late CameraDescription cameraDescription;
  String capturedImage = "";
  bool show = true;
  DataController dataController = Get.put(DataController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Camera camera = Get.put(Camera());
    return Scaffold(
      body: Column(
        children: [
          show == false
              ? Container(
                  width: w,
                  height: h * 0.8,
                  color: Colors.black,
                )
              : SizedBox(
                  width: w,
                  height: h * 0.8,
                  child: CameraPreview(camera.cameraController),
                ),
          GestureDetector(
            onTap: () {
              _takePicture(camera);
            },
            child: Container(
              width: w,
              height: h * 0.2,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Center(
                  child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 5)),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                  ),
                ),
              )),
            ),
          )
        ],
      ),
    );
  }

  void _takePicture(camera) async {
    try {
      //final path = '${Directory.systemTemp.path}/image.png';
      XFile file = await camera.cameraController.takePicture();
      capturedImage = file.path;
      dataController.filePath = file.path;
      print(dataController.filePath);
      userController.getCurrentLocation();
      Get.to(ImageViewer(path: capturedImage),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }
}
