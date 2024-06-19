import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/views/home.dart';

class ErrorBottomSheet extends StatelessWidget {
  ErrorBottomSheet({super.key, required this.error});

  String error;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 201, 201, 201)),
                child: Center(
                  child: Icon(
                    Icons.error_rounded,
                    color: AppConstants.customRedLight,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  error,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      color: AppConstants.customRed,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Spacer(), // Push the bottom container to the bottom
          GestureDetector(
            onTap: () {
              Get.back();
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
