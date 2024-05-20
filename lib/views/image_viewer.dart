import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/controllers/user_controller.dart';

class ImageViewer extends StatefulWidget {
  String path;
  ImageViewer({
    super.key,
    required this.path,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    UserController userController = Get.put(UserController());
    return Scaffold(
      
      bottomNavigationBar: Container(
          width: w,
          height: h * 0.07,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: const Center(
            child: Text("Confirm Image",style: TextStyle(fontFamily: 'man-r',fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ),
      appBar: AppBar(title:  const Text('Confirm Image',style: TextStyle(fontSize: 18,fontFamily: 'man-sb',color: Colors.black,),)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w,
            height: h * 0.6,
            child: Image.file(
              alignment: Alignment.topLeft,
              File(widget.path),
              fit: BoxFit.fill,
            ), 
          ),
          Text(userController.userModel.latitude.toString()),
          Text(userController.userModel.longitude.toString()),
          
        ],
      ),
    );
  }
}