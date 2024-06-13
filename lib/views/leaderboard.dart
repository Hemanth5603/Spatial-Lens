import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  DataController dataController = Get.put(DataController());
  @override
  @override
  void initState() {
    super.initState();
    // Delay the getLeaderBoard call to avoid issues during the build process
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.getLeaderBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 252, 255),
        body: SafeArea(
          child: Obx(
            () => dataController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "LeaderBoard",
                            style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                color: Color.fromARGB(255, 207, 233, 255),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 190, 215, 255),
                                      blurRadius: 100)
                                ]),
                            child: Center(
                              child: Image.asset(
                                "assets/icons/podium.png",
                                width: 100,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 212,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 35),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(190, 221, 221, 221)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(200, 240, 248, 255),
                                      blurRadius: 15)
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                LeaderboardTile(
                                  icon: "assets/icons/first.png",
                                  name: "Ishitha",
                                  contributions: "26",
                                  last: false,
                                ),
                                LeaderboardTile(
                                  icon: "assets/icons/second.png",
                                  name: "Hemanth",
                                  contributions: "26",
                                  last: false,
                                ),
                                LeaderboardTile(
                                  icon: "assets/icons/third.png",
                                  name: "Ishitha",
                                  contributions: "26",
                                  last: true,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}

class LeaderboardTile extends StatelessWidget {
  String icon;
  String name;
  String contributions;
  bool last;
  LeaderboardTile(
      {super.key,
      required this.contributions,
      required this.icon,
      required this.name,
      required this.last});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(vertical: 00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        icon,
                        width: 40,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'man-r',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 184, 223, 255)),
                child: Center(
                  child: Text(contributions.toString(),
                      style: TextStyle(
                          fontFamily: 'poppins', color: Colors.white)),
                ),
              )
            ],
          ),
          if (last == false)
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: MediaQuery.of(context).size.width - 50,
              height: 1,
              color: Color.fromARGB(132, 206, 206, 206),
            )
        ],
      ),
    );
  }
}
