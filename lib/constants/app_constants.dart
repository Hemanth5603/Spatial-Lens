import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:iitt/views/leaderboard.dart';
import 'package:iitt/views/tabs/home_page.dart';
import 'package:iitt/views/tabs/profile/profile_page.dart';

class AppConstants {
  static List<BottomNavigationBarItem> tabs = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined),
        activeIcon: Icon(Icons.person_2_rounded),
        label: 'Profile'),
  ];

  static List<Widget> screens = const [
    HomePage(),
    LeaderboardPage(),
    ProfilePage(),
  ];

  static List<TabItem> items = const [
    TabItem(icon: Icons.home_rounded, title: 'Home'),
    TabItem(
      icon: Icons.leaderboard,
      title: 'LeaderBoard',
    ),
    TabItem(
      icon: Icons.person_rounded,
      title: 'profile',
    ),
  ];

  static List<String> choices = [
    "Agriculture",
    "Hydrology",
    "Medicine",
    "Gaming",
    "Park",
    "Temple",
    "Hostel",
    "Play Ground",
    "Indoor Stadium",
    "School",
    "Church",
    "Masjid",
    "Educational Institute",
    "Hospital",
    "Hotel",
    "Bus Station",
    "Railway Station",
    "Airport",
    "Restaurant",
    "Parking Spot",
    "Trakking Spot",
    "Oceono",
    "Remote Sensing",
    "Transport",
    "Drones",
    "Ground",
    "Water",
    "Forestry",
    "Geology",
    "Office",
    "Lakes",
    "Shop",
  ];

  static List<String> limits = [
    "Top 5",
    "Top 10",
    "Top 20",
  ];

  static List<String> indianStates = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Lakshadweep",
    "Delhi",
    "Puducherry",
    "Ladakh",
    "Jammu and Kashmir",
  ];

  static Color customRed = Color.fromARGB(255, 149, 27, 42);
  static Color customRedLight = Color.fromARGB(235, 172, 32, 48);
  static Color customRedLight2 = Color.fromARGB(252, 255, 223, 227);
  static Color customGreen = const Color.fromARGB(255, 27, 133, 84);
  static Color customYellow = const Color.fromARGB(255, 194, 178, 138);
  static Color customBlue = Color.fromARGB(255, 0, 86, 224);
}
