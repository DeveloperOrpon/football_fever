import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

inputRoundedDecoration({required Color color, required Color bgColor, Widget? suffixIcon, String hintText = ''}) =>
    InputDecoration(
      hintText: hintText,
      fillColor: bgColor,
      filled: true,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: BorderSide(
            color: color,
            width: .5,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: BorderSide(
            color: color,
            width: .5,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: BorderSide(
            color: color,
            width: 1.1,
          )),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
    );

const noBorder = UnderlineInputBorder(
  borderSide: BorderSide.none,
);
