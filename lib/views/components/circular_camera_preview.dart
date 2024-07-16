import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CircularCameraPreview extends StatelessWidget {
  final CameraController controller;

  const CircularCameraPreview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            width: 387.87,
            height: 720,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}
