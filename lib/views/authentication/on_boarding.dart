import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide SwapEffect;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: AppConstants.customBlue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                AppConstants.onBoardTitles[currentIndex],
                style: const TextStyle(
                    fontFamily: 'man-b', fontSize: 25, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppConstants.onboardDescriptions[currentIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'man-r', fontSize: 14, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: SwapEffect(
                  activeDotColor: const Color.fromARGB(255, 255, 255, 255),
                  dotColor: Colors.grey.shade400,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (currentIndex == 2) {
                    Get.to(() => const Login(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft);
                    ;
                  }
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      currentIndex == 2 ? "Continue" : "Next",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 18,
                          color: AppConstants.customBlue),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              dragStartBehavior: DragStartBehavior.start,
              scrollDirection: Axis.horizontal,
              children: [onBoardPage1(), onBoardPage2(), onBoardPage3()],
            ),
          ],
        ));
  }

  Widget onBoardPage1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Spatial Lens",
                style: TextStyle(
                  fontFamily: 'man-r',
                  fontSize: 20,
                  color: AppConstants.customBlue,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(60),
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    "assets/gifs/Photo.gif",
                    width: 80,
                  ).animate(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget onBoardPage2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Spatial Lens",
                style: TextStyle(
                  fontFamily: 'man-r',
                  fontSize: 20,
                  color: AppConstants.customBlue,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    "assets/gifs/Uploading2.gif",
                    width: 80,
                  ).animate(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget onBoardPage3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Spatial Lens",
                style: TextStyle(
                  fontFamily: 'man-r',
                  fontSize: 20,
                  color: AppConstants.customBlue,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    "assets/gifs/Growing.gif",
                    width: 80,
                  ).animate(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
