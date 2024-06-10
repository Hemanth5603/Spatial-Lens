import 'package:flutter/material.dart';

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

  static List<String> choices = [
    "Agriculture",
    "Hydrology",
    "Medicine",
    "Gaming",
    "Glacier",
    "Oceono",
    "Graphy",
    "Landscaping",
    "Remote Sensing",
    "Transport",
    "Drones",
    "Ground",
    "Water",
    "Geo-Statistics",
    "LULC",
    "Forestry",
    "City Planning",
    "Refineeries",
    "Geology",
    "Ocean GIS Case Study",
    "Geodesy GIS Case Study",
    "Urban GIS Case Study",
    "Telecommunication GIS Case Study",
    "Transmission GIS Case Study",
    "Real Estate GIS Case Study",
    "Municipal GIS Case Study",
    "Mining GIS Case Study"
  ];

  static Color customRed = Color.fromARGB(255, 149, 27, 42);
  static Color customRedLight = Color.fromARGB(235, 172, 32, 48);
  static Color customRedLight2 = Color.fromARGB(252, 255, 223, 227);
  static Color customGreen = const Color.fromARGB(255, 27, 133, 84);
  static Color customYellow = const Color.fromARGB(255, 194, 178, 138);
}
