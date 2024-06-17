import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/data_controller.dart';
import 'package:iitt/controllers/user_controller.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  DataController dataController = Get.put(DataController());
  UserController userController = Get.put(UserController());
  @override
  @override
  void initState() {
    super.initState();
    // Delay the getLeaderBoard call to avoid issues during the build process
    callGetUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.getLeaderBoard();
    });
    Future.delayed(const Duration(seconds: 2), () {});
  }

  Future<void> callGetUser() async {
    await userController.getUser();
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
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back_ios_rounded))
                              ],
                            ),
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
                            width: 150,
                            height: 150,
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
                                width: 70,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
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
                                  userRank: userController.userModel.rank!,
                                  index: 0,
                                  icon: "assets/icons/first.png",
                                  name: dataController.leaderboardModel
                                          .leaderboard![0].name ??
                                      "User 1",
                                  contributions: dataController.leaderboardModel
                                      .leaderboard![0].contributions
                                      .toString(),
                                  profileImage: dataController.leaderboardModel
                                      .leaderboard![0].profileImage
                                      .toString(),
                                  last: false,
                                  isIcon: true,
                                ),
                                LeaderboardTile(
                                  userRank: userController.userModel.rank!,
                                  index: 0,
                                  icon: "assets/icons/second.png",
                                  name: dataController.leaderboardModel
                                          .leaderboard![1].name ??
                                      "User 2",
                                  contributions: dataController.leaderboardModel
                                      .leaderboard![1].contributions
                                      .toString(),
                                  profileImage: dataController.leaderboardModel
                                      .leaderboard![1].profileImage
                                      .toString(),
                                  last: false,
                                  isIcon: true,
                                ),
                                LeaderboardTile(
                                  userRank: userController.userModel.rank!,
                                  index: 0,
                                  icon: "assets/icons/third.png",
                                  name: dataController.leaderboardModel
                                          .leaderboard![2].name ??
                                      "User 3",
                                  profileImage: dataController.leaderboardModel
                                      .leaderboard![2].profileImage
                                      .toString(),
                                  contributions: dataController.leaderboardModel
                                      .leaderboard![2].contributions
                                      .toString(),
                                  last: true,
                                  isIcon: true,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppConstants.customBlue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Rank",
                                  style: TextStyle(
                                      fontFamily: 'man-r',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color:
                                      const Color.fromARGB(195, 255, 255, 255),
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontFamily: 'man-r',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color:
                                      const Color.fromARGB(195, 255, 255, 255),
                                ),
                                Text(
                                  "Contributions",
                                  style: TextStyle(
                                      fontFamily: 'man-r',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 255,
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(190, 221, 221, 221)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(200, 240, 248, 255),
                                        blurRadius: 15)
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: dataController.leaderboardModel
                                            .leaderboard!.length -
                                        3,
                                    itemBuilder: (context, index) {
                                      print(
                                          "${userController.userModel.rank} = ${index + 3}");
                                      return LeaderboardTile(
                                        userRank:
                                            userController.userModel.rank!,
                                        profileImage: dataController
                                            .leaderboardModel
                                            .leaderboard![index + 3]
                                            .profileImage
                                            .toString(),
                                        index: index,
                                        contributions: dataController
                                            .leaderboardModel
                                            .leaderboard![index + 3]
                                            .contributions
                                            .toString(),
                                        icon: "assets/icons/bronze.png",
                                        name: dataController.leaderboardModel
                                            .leaderboard![index + 3].name
                                            .toString(),
                                        last: dataController.leaderboardModel
                                                        .leaderboard!.length -
                                                    1 ==
                                                index
                                            ? true
                                            : false,
                                        isIcon: false,
                                      );
                                    }),
                              )),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}

class LeaderboardTile extends StatelessWidget {
  int userRank;
  int index;
  String icon;
  String name;
  String contributions;
  bool last;
  bool isIcon;
  String profileImage;
  LeaderboardTile(
      {super.key,
      required this.userRank,
      required this.index,
      required this.contributions,
      required this.icon,
      required this.name,
      required this.last,
      required this.isIcon,
      required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: userRank == index - 3
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(255, 255, 255, 255),
      ),
      padding: EdgeInsets.only(bottom: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  isIcon == true
                      ? Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            icon,
                            width: 30,
                          ))
                      : Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text((index + 4).toString())),
                  SizedBox(
                    width: 16,
                  ),
                  profileImage == "Default"
                      ? Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 233, 243, 255),
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.person_rounded,
                              size: 16,
                              color: Color.fromARGB(190, 23, 110, 182)),
                        )
                      : Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 1, color: Colors.white),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${ApiConstants.s3Url}${profileImage}"))),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'man-r',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                width: 25,
                height: 25,
                margin: EdgeInsets.only(right: 20),
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
          last == false
              ? Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color.fromARGB(132, 206, 206, 206),
                )
              : Container(
                  width: 0,
                  height: 0,
                )
        ],
      ),
    );
  }
}
