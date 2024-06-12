import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/main.dart';
import 'package:iitt/views/tabs/home_page.dart';
import 'package:iitt/views/tabs/profile_page.dart';
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeletonizer(enabled: isLoading, child: HomePage()),
    );
  }
}












 // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: Color.fromARGB(255, 255, 249, 249),
      //     selectedItemColor: AppConstants.customRed,
      //     unselectedItemColor: AppConstants.customRed,
      //     elevation: 10,
      //     currentIndex: selectedIndex,
      //     onTap: (value) {
      //       setState(() {
      //         if (value == 0) {}
      //         selectedIndex = value;
      //       });
      //       pageController.animateToPage(selectedIndex,
      //           duration: const Duration(milliseconds: 600),
      //           curve: Curves.easeOutQuad);
      //     },
      //     items: AppConstants.tabs),
      // body: PageView(
      //   controller: pageController,
      //   children: const <Widget>[
      //     HomePage(),
      //     ProfilePage(),
      //   ],
      // ),