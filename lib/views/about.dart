import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 20,
                        child: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: const BoxDecoration(),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 300,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/icons/iittnmicps.png'))),
                    ),
                  ),
                ),
                const SizedBox(
                  child: Text(
                    "What is Spatial Lens ?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Spatial Lens is an innovative app designed to empower users to capture and collect geospatial images and data from low-lying and remote areas, such as villages and rural landscapes. With a focus on contributing to geospatial research and analytics, CaptureGeo helps in gathering valuable data that can drive meaningful insights and benefit various industries.",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  child: Text(
                    "Why Spatial Lens ?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Spatial Lens is designed to support geospatial researchers in collecting and analyzing data from underrepresented areas. By participating, you are contributing to a database that can be used to apply advanced analytics, ultimately helping industries derive valuable insights and make informed decisions.",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  child: Text(
                    "Join The Movement",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Be a part of the initiative to map and document our rural and remote areas. Your contributions can lead to impactful research and development across various sectors.",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: SizedBox(
                    child: Text(
                      "Developer Contact",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 56, 56, 56)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await launchLinkedIn();
                        },
                        child: Image.asset(
                          "assets/icons/linkedin.png",
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () => launchGithub(),
                        child: Image.asset(
                          "assets/icons/github.png",
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  child: Text(
                    "Developed by IITTNiF Innovation Hub Tirupati with ❤️",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 94, 94, 94)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchLinkedIn() async {
    var url =
        Uri.parse("https://www.linkedin.com/in/hemanth-srinivas-a20b21231/");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchGithub() async {
    var url = Uri.parse("https://github.com/Hemanth5603");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
