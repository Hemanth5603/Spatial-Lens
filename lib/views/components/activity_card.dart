import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iitt/constants/api_constants.dart';
import 'package:iitt/constants/app_constants.dart';
import 'package:iitt/models/activity_model.dart';
import 'package:iitt/views/activity_viewer.dart';

class activityCard extends StatelessWidget {
  activityCard(
      {super.key,
      required this.imageUrl,
      required this.category,
      required this.index,
      required this.latitude,
      required this.longitude,
      required this.remarks});
  String? imageUrl;
  String? category;

  String? latitude;
  String? longitude;
  String? remarks;

  int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            ActivityViewer(
                imageUrl: imageUrl!,
                category: category!,
                latitude: latitude!,
                longitude: longitude!,
                remarks: remarks ?? "No Remarks"),
            transition: Transition.rightToLeft,
            duration: 300.milliseconds);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppConstants.customBlue,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${ApiConstants.s3Url}$imageUrl"))),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        category!,
                        style: TextStyle(
                            fontFamily: 'man-r',
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppConstants.customBlue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color.fromARGB(148, 194, 194, 194),
            )
          ],
        ),
      ),
    );
  }
}
