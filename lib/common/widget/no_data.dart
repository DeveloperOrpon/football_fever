import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/image_const.dart';
import 'package:get/get.dart';

class NoDataCustomWidget extends StatelessWidget {
  final Function()? onRefresh;
  final double bottomSize;
  final String? buttonText;
  final String? titleText;
  const NoDataCustomWidget(
      {super.key,
      this.onRefresh,
      this.bottomSize = 200,
      this.buttonText,
      this.titleText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            appNameLogo,
            height: 100.h,
            color: Get.theme.secondaryHeaderColor,
          ),
          8.verticalSpace,
          Text(
            (titleText ?? 'No Data Found').toUpperCase(),
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: 1.5,
              color: Get.theme.disabledColor.withOpacity(.3),
            ),
          ),
          4.verticalSpace,
          Text(
            textAlign: TextAlign.center,
            'There seems to be no data available to show Try in some other time'
                .toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              color: Get.theme.disabledColor.withOpacity(.3),
            ),
          ),
          10.verticalSpace,
          if (onRefresh != null)
            MaterialButton(
              elevation: 0,
              onPressed: onRefresh,
              color: Get.theme.primaryColor,
              child: Text(
                buttonText ?? "TRY AGAIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          bottomSize.verticalSpace,
        ],
      )
          .animate(
            onPlay: (controller) => controller.repeat(reverse: false),
          )
          .shimmer(
            // angle: 90,
            color: Get.theme.primaryColor.withOpacity(.5),
            duration: 3000.ms,
            delay: 1000.ms,
          ),
    );
  }
}
