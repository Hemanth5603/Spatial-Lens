import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/main.dart';
import 'package:iitt/views/leaderboard.dart';
import 'package:iitt/views/tabs/home_page.dart';
import 'package:iitt/views/tabs/profile/profile_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;
  late PageController pageController;
  var isLoading = false;
  DataController dataController = Get.put(DataController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeHome();
    });

    pageController.addListener(() {
      int currentPage = pageController.page!.round();
      if (currentPage != selectedIndex) {
        setState(() {
          selectedIndex = currentPage;
        });
      }
    });
  }

  Future initializeHome() async {
    setState(() {
      isLoading = true;
    });
    await dataController.getActivity();
    await userController.getUser();
    await dataController.getLeaderBoard("Top 0", "Default");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarDefault(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: AppConstants.items,
        indexSelected: selectedIndex,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 168, 216, 255),
        colorSelected: AppConstants.customBlue,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: AppConstants.screens,
      ),
    );
  }
}
