import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/views/home.dart';

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: w,
            height: h * 0.1,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/check.png"))),
          ),
          const SizedBox(height: 20),
          Text(
            'Data Uploaded Successfully ',
            style: TextStyle(fontSize: 20.0, fontFamily: 'poppins'),
          ),
          Spacer(), // Push the bottom container to the bottom
          GestureDetector(
            onTap: () {
              // Get.offAll(ImageCapture(),
              //     transition: Transition.leftToRight,
              //     duration: 300.milliseconds);
              Get.offAll(const Home(),
                  transition: Transition.leftToRight,
                  duration: 300.milliseconds);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Go Back !',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
