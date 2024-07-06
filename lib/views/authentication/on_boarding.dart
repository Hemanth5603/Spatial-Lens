import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iitt/constants/app_constants.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          dragStartBehavior: DragStartBehavior.start,
          scrollDirection: Axis.horizontal,
          children: [
            onBoardPage("Capture Geospatial Data", ""),
            onBoardPage("Capture Geospatial Data", "")
          ],
        ),
        
      ],
    ));
  }
}

Widget onBoardPage(String title, String image) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "SpatialLens",
        style: TextStyle(
            fontFamily: 'man-r', fontSize: 18, color: AppConstants.customBlue),
      )
    ],
  ));
}
