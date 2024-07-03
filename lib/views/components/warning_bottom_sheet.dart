import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/views/home.dart';

class WarningBottomSheet extends StatelessWidget {
  WarningBottomSheet(
      {super.key,
      required this.successMessage,
      required this.onPressed,
      required this.buttonText,
      required this.textColor});

  String successMessage;
  String buttonText;
  final VoidCallback onPressed;
  Color textColor;

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
                    color: Color.fromARGB(255, 238, 238, 238)),
                child: Center(
                    child: Icon(
                  Icons.warning_rounded,
                  color: AppConstants.customRedLight,
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  successMessage,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              onPressed(); // Invoke the onPressed function
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  buttonText,
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
