import 'package:flutter/material.dart';
import 'package:iitt/constants/app_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 248, 253),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppConstants.customRed, width: 4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                                ))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hemanth Srinivas",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(54, 207, 207, 207),
                                blurRadius: 20)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProfileTile(Icons.email_outlined, "Email",
                              "shemanth.kgp@gmail.com"),
                          ProfileTile(Icons.call, "Phone", "+91 7997435603"),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileTile(icon, title, value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 233, 236, 255),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Color.fromARGB(255, 117, 117, 117),
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  value,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: const Color.fromARGB(255, 224, 224, 224),
          )
        ],
      ),
    );
  }
}
