import 'package:firebase_core/firebase_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/controllers/user_controller.dart';
import 'package:iitt/firebase_options.dart';
import 'package:iitt/views/authentication/location.dart';
import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/authentication/register.dart';
import 'package:iitt/views/home.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:iitt/views/image_viewer.dart';
import 'package:iitt/views/tabs/home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isLoggedIn =
      prefs.getInt("isLoggedIn") == null || prefs.getInt("isLoggedIn") == 0
          ? 0
          : 1;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

  requestPermissions();
}

late SharedPreferences prefs;
int isLoggedIn = 0;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          fontFamily: 'poppins',
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          primaryColor: AppConstants.customBlue,
          colorScheme: ColorScheme.light(primary: AppConstants.customBlue)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoggedIn == 1 ? Home() : const Login(),
      ),
    );
  }
}

Future<void> requestPermissions() async {
  // Request all permissions at once
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
    Permission.microphone,
  ].request();

  // Check the statuses and handle them accordingly
  if (statuses[Permission.location]!.isGranted &&
      statuses[Permission.camera]!.isGranted &&
      statuses[Permission.microphone]!.isGranted) {
    print('All permissions granted');
  } else {
    print('One or more permissions denied');
  }
}
