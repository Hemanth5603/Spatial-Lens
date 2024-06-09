import 'package:iitt/views/authentication/login.dart';
import 'package:iitt/views/authentication/register.dart';
import 'package:iitt/views/image_capture.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isLoggedIn =
      prefs.getInt("isLoggedIn") == null || prefs.getInt("isLoggedIn") == 0
          ? 0
          : 1;
  runApp(const MainApp());
}

late SharedPreferences prefs;
int isLoggedIn = 0;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoggedIn == 1 ? ImageCapture() : const Login(),
      ),
    );
  }
}
