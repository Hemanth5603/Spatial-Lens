import 'package:choice/choice.dart';
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
  String? selectedLimit = "Top 0";
  String? selectedCategory = "Default";

  @override
  void initState() {
    super.initState();
    // Delay the getLeaderBoard call to avoid issues during the build process
    callGetUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.getLeaderBoard(selectedLimit, selectedCategory);
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Center(
                    child: const Text(
                      "LeaderBoard",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
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
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: InlineChoice<String>.single(
                      clearable: true,
                      value: selectedLimit,
                      onChanged: (String? value) {
                        setState(() {
                          selectedLimit = value;
                          dataController.getLeaderBoard(
                              selectedLimit, selectedCategory);
                        });
                      },
                      itemCount: AppConstants.limits.length,
                      itemBuilder: (state, i) {
                        return ChoiceChip(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          selected: state.selected(AppConstants.limits[i]),
                          onSelected: state.onSelected(AppConstants.limits[i]),
                          label: Text(
                            AppConstants.limits[i],
                            style: TextStyle(
                              fontFamily: 'poppins',
                              color: state.selected(AppConstants.limits[i])
                                  ? Colors.white
                                  : AppConstants.customBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          selectedColor: AppConstants.customBlue,
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: AppConstants
                                  .customBlue, // Set the border color
                            ),
                          ),
                          avatar: state.selected(AppConstants.limits[i])
                              ? null
                              : null,
                        );
                      },
                      listBuilder: ChoiceList.createScrollable(
                        spacing: 10,
                        runSpacing: 10,
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      ),
                    ),
                  ),
                  InlineChoice<String>.single(
                    clearable: true,
                    value: selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value;
                        dataController.getLeaderBoard(
                            selectedLimit, selectedCategory);
                      });
                    },
                    itemCount: AppConstants.choices.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        selected: state.selected(AppConstants.choices[i]),
                        onSelected: state.onSelected(AppConstants.choices[i]),
                        label: Text(
                          AppConstants.choices[i],
                          style: TextStyle(
                            fontFamily: 'poppins',
                            color: state.selected(AppConstants.choices[i])
                                ? Colors.white
                                : AppConstants.customBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        selectedColor: AppConstants.customBlue,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color:
                                AppConstants.customBlue, // Set the border color
                          ),
                        ),
                        avatar: state.selected(AppConstants.choices[i])
                            ? null
                            : null,
                      );
                    },
                    listBuilder: ChoiceList.createScrollable(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          color: const Color.fromARGB(195, 255, 255, 255),
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
                          color: const Color.fromARGB(195, 255, 255, 255),
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
                    height: 420,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                    child: Obx(() => dataController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            child: ListView.builder(
                                itemCount: dataController
                                    .leaderboardModel.leaderboard!.length,
                                itemBuilder: (context, index) {
                                  print(
                                      "${userController.userModel.rank} = ${index}");
                                  return LeaderboardTile(
                                    userRank: userController.userModel.rank!,
                                    profileImage: dataController
                                        .leaderboardModel
                                        .leaderboard![index]
                                        .profileImage
                                        .toString(),
                                    index: index,
                                    contributions: dataController
                                        .leaderboardModel
                                        .leaderboard![index]
                                        .contributions
                                        .toString(),
                                    icon: "assets/icons/bronze.png",
                                    name: dataController.leaderboardModel
                                        .leaderboard![index].name
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
                  )
                ],
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
    return Column(
      children: [
        Container(
          height: 58,
          decoration: BoxDecoration(
              color: userRank == index + 1
                  ? AppConstants.customBlue
                  : Color.fromARGB(255, 255, 255, 255),
              borderRadius: index == 0
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))
                  : BorderRadius.circular(0)),
          padding: EdgeInsets.only(bottom: 10, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (index + 1 == 1)
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset(
                              "assets/icons/first.png",
                              width: 25,
                            ))
                      else if (index + 1 == 2)
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset(
                              "assets/icons/second.png",
                              width: 25,
                            ))
                      else if (index + 1 == 3)
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset(
                              "assets/icons/third.png",
                              width: 25,
                            ))
                      else
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10),
                            child: Text((index + 1).toString())),
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
                                  border:
                                      Border.all(width: 1, color: Colors.white),
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
                          fontWeight: FontWeight.w500,
                          color: userRank == index + 1
                              ? Colors.white
                              : const Color.fromARGB(255, 48, 48, 48),
                        ),
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
            ],
          ),
        ),
        last == false
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color.fromARGB(132, 206, 206, 206),
              )
            : Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }
}



// Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 200,
//                             margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: Color.fromARGB(190, 221, 221, 221)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color.fromARGB(200, 240, 248, 255),
//                                       blurRadius: 15)
//                                 ],
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 LeaderboardTile(
//                                   userRank: userController.userModel.rank!,
//                                   index: 0,
//                                   icon: "assets/icons/first.png",
//                                   name: dataController.leaderboardModel
//                                           .leaderboard![0].name ??
//                                       "User 1",
//                                   contributions: dataController.leaderboardModel
//                                       .leaderboard![0].contributions
//                                       .toString(),
//                                   profileImage: dataController.leaderboardModel
//                                       .leaderboard![0].profileImage
//                                       .toString(),
//                                   last: false,
//                                   isIcon: true,
//                                 ),
//                                 LeaderboardTile(
//                                   userRank: userController.userModel.rank!,
//                                   index: 0,
//                                   icon: "assets/icons/second.png",
//                                   name: dataController.leaderboardModel
//                                           .leaderboard![1].name ??
//                                       "User 2",
//                                   contributions: dataController.leaderboardModel
//                                       .leaderboard![1].contributions
//                                       .toString(),
//                                   profileImage: dataController.leaderboardModel
//                                       .leaderboard![1].profileImage
//                                       .toString(),
//                                   last: false,
//                                   isIcon: true,
//                                 ),
//                                 LeaderboardTile(
//                                   userRank: userController.userModel.rank!,
//                                   index: 0,
//                                   icon: "assets/icons/third.png",
//                                   name: dataController.leaderboardModel
//                                           .leaderboard![2].name ??
//                                       "User 3",
//                                   profileImage: dataController.leaderboardModel
//                                       .leaderboard![2].profileImage
//                                       .toString(),
//                                   contributions: dataController.leaderboardModel
//                                       .leaderboard![2].contributions
//                                       .toString(),
//                                   last: true,
//                                   isIcon: true,
//                                 )
//                               ],
//                             ),
//                           ),