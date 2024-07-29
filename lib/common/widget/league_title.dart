import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

class LeagueTitle extends StatelessWidget {
  final String name;
  final String icon;
  const LeagueTitle({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 5.h,
      ),
      height: 45.h,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Row(
        children: [
          NetImageView(
            fit: BoxFit.contain,
            indicatorColor: Colors.white,
            url: icon,
            height: 45.h,
            width: 45.w,
            type: '',
          ),
          Expanded(
              child: Text(
            name,
            style: Get.theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
            ),
          )),
          Text(
            'See All',
            style: Get.theme.textTheme.labelMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          5.horizontalSpace,
        ],
      ),
    );
  }
}
