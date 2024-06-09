import 'package:iitt/controllers/image_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/views/image_viewer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  late CameraController controller;
  late CameraDescription cameraDescription;
  String capturedImage = "";
  bool show = false;
  ImageController imageController = Get.put(ImageController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      cameraDescription = await availableCameras().then((value) =>
          value.firstWhere(
              (element) => element.lensDirection == CameraLensDirection.back));
      if (cameraDescription != null) {
        controller = CameraController(cameraDescription, ResolutionPreset.high);
        controller.initialize().then((value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                  child: CameraPreview(controller),
                ),
          GestureDetector(
            onTap: () {
              _takePicture(imageController);
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

  void _takePicture(imageController) async {
    try {
      //final path = '${Directory.systemTemp.path}/image.png';
      XFile file = await controller.takePicture();
      capturedImage = file.path;
      imageController.filePath = file.path;
      print(imageController.filePath);
      userController.getCurrentLocation();
      Get.to(ImageViewer(path: capturedImage),
          transition: Transition.rightToLeft, duration: 300.milliseconds);
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }
}
