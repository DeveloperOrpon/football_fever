import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../clipper/tri_angle_clipper.dart';

class TimeTile extends StatelessWidget {
  final String date;
  const TimeTile({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 80,
                height: 20,
                color: Get.theme.primaryColor,
              ),
            ),
          ),
          10.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: Get.theme.textTheme.titleLarge!.copyWith(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
              Text(
                "5 Matches",
                style: Get.theme.textTheme.titleLarge!.copyWith(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: 80,
              height: 20,
              color: Get.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
