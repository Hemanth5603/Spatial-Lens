import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:iitt/views/leaderboard.dart';
import 'package:iitt/views/tabs/home_page1.dart';
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
    HomePage1(),
    LeaderboardPage(),
    ProfilePage(),
  ];

  static List<String> onBoardTitles = [
    "Capture Geo-Spatial Data",
    "Review and Upload ",
    "Grow Up on the LeaderBoard",
  ];

  static List<String> onboardDescriptions = [
    "Discover our innovative app for capturing geospatial data, designed to seamlessly record and document locations of small scale vendors with precision. Just snap a picture and select a category",
    "Review and categorize the data according to predefined categories. Once categorized, data is uploaded after admin approval",
    "Grow on the leaderboard on every successfull and valid contribution made by you !!"
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
  "Street Food",
  "Food truck",
  "Fruit vendor",
  "Vegetable vendor",
  "Bakeries shop",
  "Juice vendor",
  "Grocery/Kirana shop",
  "Tea Shop",
  "Toys/balloon seller",
  "Vehicle repair shop",
  "Footwear seller",
  "Bag/footwear Repair Shop",
  "Earthen pot vendor",
  "Saloon Shop",
  "Xerox Shop",
  "Water Supplier",
  "Car/Bike Cleaning Shop",
  "Sugarcane Juice",
  "Meat Shop",
  "Public Toilet",
  "Googles/glares seller",
  "Flower vendor",
  "Plastic item seller",
  "Broom seller",
  "Tailor Shop",
  "Stationery shop",
  "Electronics Repair Shop",
  "Mobile service/recharge shop",
  "Event Planners",
  "Transportation service",
  "Tutoring centre",
  "Painting shop",
  "Photo Studio",
  "Beauty parlour",
  "Medical pharmacy",
  "Tree",
  "Printer/banners Shop",
  "Hardware/Plumbing Shop",
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

  static Color customRed = const Color.fromARGB(255, 149, 27, 42);
  static Color customRedLight = const Color.fromARGB(235, 172, 32, 48);
  static Color customRedLight2 = const Color.fromARGB(252, 255, 223, 227);
  static Color customGreen = const Color.fromARGB(255, 27, 133, 84);
  static Color customYellow = const Color.fromARGB(255, 194, 178, 138);
  static Color customBlue = const Color.fromARGB(255, 0, 86, 224);
}
